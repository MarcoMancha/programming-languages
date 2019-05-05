import csv

with open('heroes_information.csv', 'rb') as csvfile:
    data = list(csv.reader(csvfile))

guess = ""
clause = ""
information = {}
powers = {}

for name, gender, eye_color, race, hair_color, publisher, skin_color, alignment in data:
    name = name.lower()
    information[name] = 1

reader = csv.reader(open('super_hero_powers.csv'))

for row in reader:
    key = row[0]
    key = key.lower()
    powers[key] = row[1:]

dict_poderes = powers["powers"]

for name, gender, eye_color, race, hair_color, publisher, skin_color, alignment in data:
    name = name.lower()
    if name in information and name in powers:

        lista_poderes = ""
        i = 0
        cuenta = 0
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

        if cuenta > 0:
            guess += "guess("+ name +"):- " + name +".\n"
            g = ""
            e = r = h = p = s = a = g

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

            clause += "\n" + name + ":-\n"+ g + a + p + r + e + h + s + "  (" + lista_poderes + ").\n"

guess += "guess(someone_idk).\n"

f = open("db.pl", "w")
f.write(guess)
f.write(clause)
f.close()
