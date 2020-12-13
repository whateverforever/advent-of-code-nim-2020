"""
# Kommentare:

## Allgemein:

- Kleinschreibung: Normalerweise schreibt alle Variablen in Python klein. Worte werden
                   per Unterstrich verbunden ("snake case"): text_parser, james_bond
- Grosschreibung: Das einzige was in Python gross geschrieben wird sind Klassen und
                  Typen. Die werden dann in PascalCase geschrieben: FieldController,
                  HeadphoneCable, etc.
"""

# "controller" ist ziemlich nichtssagen, was controllt dieser Controller? was macht er?
def controller(Feld):
    Feld = Feld
    # Was ist count? was countet der?
    count = 0
    try:
        PassID1 = re.compile(r"pid:([0-9]{10})").findall(Feld)
        valid = bool(PassID1)
        # Würde ich durch `if valid` ersetzen
        if valid == True:
            return False
    except:
        pass

    # Das Konstrukt der folgenden Drei try-Blöcke verstehe ich nicht,
    # warum sind das drei return-Blöcke und kein if-else?
    try:
        hgt = re.compile(r"hgt:").findall(Feld)
        valid = bool(hgt)
        if valid == False:
            return False
    except:
        pass
    try:
        count += 1
        # Die Regexe kannst du kombinieren mit r"hgt:(\d+)(cm|in)":
        # sprich "eine oder mehrere zahlen, gefolgt von cm oder in"
        cm = re.compile(r"hgt:(\d{3})cm").findall(Feld)[0]
        count += 1
        valid = int(cm) >= 150 and int(cm) <= 193
        if valid == False:
            return False
    except IndexError:
        pass
    try:
        count += 1
        inch = re.compile(r"hgt:(\d{2})in").findall(Feld)[0]
        count += 1
        valid = int(inch) >= 59 and int(inch) <= 76
        if valid == False:
            return False
    except IndexError:
        pass

    # Wie oben angemerkt habe ich jetzt keine Ahnung was dieser Code hier macht,
    # welcher count wird hier geprüft?
    if count < 3:
        return False

    try:
        eye = re.compile(r"ecl:(\w{3})").findall(Feld)[0]
        birth = re.compile(r"byr:(\d{4})").findall(Feld)[0]
        issue = re.compile(r"iyr:(\d{4})").findall(Feld)[0]
        expiration = re.compile(r"eyr:(\d{4})").findall(Feld)[0]

        # Diese Pyramide check ich auch nicht. Warum sind die alle ineinander?
        # Oder ist das nur ein Formatierungsfehler durch die E-Mail?
        valid = int(birth) >= 1920 and int(birth) <= 2002
        if valid == True:
            # Die getrennte Definition von `valid = ...`` und `if valid` macht nur Sinn
            # wenn "valid" einen Dokumentationswert hat. Wenn eh alle gleich heissen
            # (und nichts aussagen) würde ich das direkt hinter das if schreiben
            valid = int(issue) >= 2010 and int(issue) <= 2020
            if valid == True:
                # print("issue")
                valid = int(expiration) >= 2020 and int(expiration) <= 2030
                if valid == True:
                    # print("exp")
                    haare = re.compile(r"#[0-9a-f]{6}").findall(Feld)
                    valid = bool(haare)
                    if valid == True:
                        # print("haare")
                        PassID = re.compile(r"pid:([0-9]{9})").findall(Feld)
                        valid = bool(PassID)
                        if valid == True:
                            # print("pass")
                            valid = (
                                eye == "amb"
                                or eye == "blu"
                                or eye == "gry"
                                or eye == "grn"
                                or eye == "hzl"
                                or eye == "oth"
                            )
                            if valid == True:
                                # print("auge")
                                return True
    except:
        return False