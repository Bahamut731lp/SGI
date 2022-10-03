# Nalezení hranic slova v nahrávce

> Příklad jednoduché úlohy na „vydolování“ informace z většího
množství dat.
Je třeba vymyslet strategii, která na základě analýzy řady čísel
odliší zvuk slova od zvuku pozadí a určí alespoň přibližně
začátek a konec slova.

- Stáhněte si z e-learningu soubor s několika nahrávkami.
- Jedná se o digitální nahrávky mluvených číslic (0 až 9), řečené a nahrané různými osobami. (Názvu jsou typu c6_p0076_s04.wav)
- Nahrávky jsou ve formátu WAV, přesně 2 sekundy dlouhé.
- Jsou nahrány se vzorkovací frekvencí 16kHz, tj. 1 s obsahuje 16000 vzorků (číselných hodnot), 2 s tedy 32000. Časový interval mezi vzorky (čili vzorkovací perioda) je 1/16000 sekundy.
- Některé nahrávky jsou velmi „čisté“, jiné mohou obsahovat šum nebo i krátké zapraskání. S tím vším, byste si měli umět poradit.

## Návrh řešení
- V Matlabu si načtěte a zobrazte jednotlivé soubory (viz dnešní příklady).
- Na základě zobrazení a vhodných nápadů zkuste vymyslet jednoduchou strategii pro nalezení míst, kde začíná a končí řeč. Ta nevzniká ani nezaniká náhle, jedná se o pozvolnější proces, takže hranice slova lze stanovit jen přibližně s přesností cca 0,05 s (50 ms)
- Možné přístupy:
    - hledat vzorky, jejichž (abs.) hodnoty významně převyšují okolí,
    - Rozdělit nahrávku na krátké segmenty (např. 100-200 vzorků dlouhé) a u nich určit nějaký vhodný parametr úměrný „hlasitosti“ signálu, apod. Následně stanovit práh pro určení začátku a konce slova.
- Nápady ověřovat na dodaných nahrávkách a postupně vytvářet co nejlepší strategii, která dá dobré výsledky na všech datech. Najít způsob, jak jednoduše ověřovat, zda jsou  nalezené hranice dobré. (Ideálně vykreslením a přehráním
výřezu.)
- Řešení včlenit do jednoduchého programu v Matlabu.

## Odevzdání řešení
- Váš finální program musí načíst nahrávku se zvoleným jménem, zobrazit ji, zanalyzovat a vykreslit a vypsat čas začátku a konce slova. Čas si spočítáte z indexu vzorku nebo segmentu. 
- Formát výstupu: `Zacatek: 0.52s Konec: 1.48 s`
- Program by měl dát rozumné výsledky na dodaných nahrávkách, ale i na dalších nahrávkách stejného typu, na kterých program otestuji.
- Abych vám úlohu uznal (za 1 bod), musíte mi poslat (jan.nouza@tul.cz) váš matlabovský program jako přílohu v mailu a s krátkým textem, který popíše a vysvětlí váš postup. Řešení musí být originální a musí být doručeno do půlnoci této soboty (1.10.)
- Mail musí příjít z vaší školní adresy x.y@tul.cz a musí mít předmět `SGI-bonus01`
- Nejlepší či jinak zajímavé řešení mohu ocenit bodem navíc.