#     Prolog application that guess the hero/villain
#     Copyright (C) 2019 Marco Antonio Mancha Alfaro
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>

import csv

#Open heroes information .csv
with open('heroes_information.csv', 'rb') as csvfile:
    data = list(csv.reader(csvfile))

#Initialize variables to store information
guess = ""
clause = ""
information = {}
powers = {}

#Check if the character is on the heroes_information .csv
for name, gender, eye_color, race, hair_color, publisher, skin_color, alignment in data:
    name = name.lower()
    information[name] = 1

#Open characters powers.csv
reader = csv.reader(open('super_hero_powers.csv'))

#Obtain the powers of each character
for row in reader:
    key = row[0]
    key = key.lower()
    powers[key] = row[1:]

dict_poderes = powers["powers"]

#Iterate through the heroes information .csv
for name, gender, eye_color, race, hair_color, publisher, skin_color, alignment in data:
    name = name.lower()

    #Check if character is on both .csv
    if name in information and name in powers:

        lista_poderes = ""
        i = 0
        cuenta = 0

        #Append all the powers of a character with the prolog fact
        for power in powers[name]:
            if power == "True":
                poder = dict_poderes[i].lower()
		if cuenta == 0:
                	lista_poderes += "check(has_"+poder+");"
		else:
			lista_poderes += "\n  check(has_"+poder+");"
                cuenta = cuenta + 1
            i = i + 1

        if lista_poderes.endswith(';'):
            lista_poderes = lista_poderes[:-1]

        #If the super hero has at least one super power
        if cuenta > 0:
            guess += "guess("+ name +"):- " + name +".\n"
            g = ""
            e = r = h = p = s = a = g

            #Assign the value of each characteristic

            if gender == "Male":
                g = "  sex(is_a_man),\n"

            if eye_color != '-':
                eye_color = eye_color.lower()
                e = "  eye_color(has_"+eye_color+"_eye_color),\n"

            if race != "-":
                race = race.lower()
                r = "  race(is_a_"+race+"),\n"

            if hair_color != "-":
                hair_color = hair_color.lower()
                h = "  hair_color(has_"+hair_color+"_hair),\n"

            if publisher != "-":
                publisher = publisher.lower()
                p = "  publisher(publisher_was_"+publisher+"),\n"

            if skin_color != "-":
                skin_color = skin_color.lower()
                s = "  skin_color(has_"+skin_color+"_skin),\n"

            if alignment != "-":
                alignment = alignment.lower()
                a = "  alignment(character_is_"+alignment+"),\n"

            #Append all the characteristics with their powers using prolog notation
            clause += "\n" + name + ":-\n"+ g + a + p + r + e + h + s + "  (" + lista_poderes + ").\n"

#Add case if the character couldn't be finded
guess += "guess(someone_idk).\n"

#Write on the output file
f = open("db.pl", "w")
f.write(guess)
f.write(clause)
f.close()
