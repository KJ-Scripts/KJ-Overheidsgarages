Config = {}

-- Algemene instellingen
Config.UseBlips = false -- Als true, dan worden er blips gemaakt voor alle garages
-- Blip instellingen zijn verwijderd op verzoek van de gebruiker

-- Marker instellingen
Config.MarkerType = 36 -- Type marker voor garage toegang
Config.MarkerColor = {r = 50, g = 50, b = 204, a = 100} -- Kleur van de marker (blauw)
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.0} -- Grootte van de marker
Config.MarkerRotation = true -- Draait de marker als true

Config.DeleteMarkerType = 1 -- Type marker voor voertuig verwijderen
Config.DeleteMarkerColor = {r = 255, g = 0, b = 0, a = 100} -- Kleur van de verwijder marker (rood)
Config.DeleteMarkerSize = {x = 3.0, y = 3.0, z = 1.0} -- Grootte van de verwijder marker

Config.DrawDistance = 10.0 -- Afstand waarop markers zichtbaar worden
Config.InteractDistance = 2.0 -- Afstand waarop interactie mogelijk is

Config.Garages = {
    [1] = {
        name = "Politie Garage",
        blip = {
            sprite = 357,
            color = 3,
            scale = 0.8,
            label = "Politie Garage"
        },
        jobs = {"police", "kmar", "dsi"},
        marker = vector3(441.4211, -995.5980, 21.8360),
        deleteMarker = vector3(438.2600, -1002.3954, 21.3360),
        spawnPoint = {
            coords = vector3(443.9583, -1006.0934, 21.3360),
            heading = 264.9976
        },
        categories = {
            ["Noodhulp"] = {
                {model = "polimperial", label = "Benefactor Imperial", livery = 0, extras = {}},
                {model = "poljogger", label = "Benefactor Jogger", livery = 0, extras = {}},
                {model = "polrebla", label = "Ubermacht Rebla", livery = 0, extras = {}}
            },
            ["SIV"] = {
                {model = "polargento1", label = "Argento 1", livery = 0, extras = {}},
                {model = "polargento2", label = "Argento 2", livery = 0, extras = {}},
                {model = "polsapneon", label = "Pfister Sapneon", livery = 0, extras = {}}
            },
            ["Offroad"] = {
                {model = "poleveron", label = "Everon", livery = 0, extras = {}}
            },
            ["Motoren"] = {
                {model = "policeb2", label = "Lichte Motor", livery = 0, extras = {}},
                {model = "politiemotor1", label = "Zware Motor", livery = 0, extras = {}},
                {model = "politiequad", label = "Quad", livery = 0, extras = {}}
            },
            ["Unmarked"] = {
                {model = "swatvanr2", label = "Benefactor Jogger", livery = 0, extras = {}},
                {model = "astronun", label = "Pfister Astronun", livery = 0, extras = {}},
                {model = "sugoi", label = "Sugoi", livery = 0, extras = {}},
                {model = "unkomodai", label = "Lampadati Komodai", livery = 0, extras = {}},
                {model = "unkuruma", label = "Karin Kuruma", livery = 0, extras = {}},
                {model = "ureblahyc", label = "Ubermacht Rebla HYC", livery = 0, extras = {}}
            },
        }
    },
    [2] = {
        name = "KMar Garage",
        blip = {
            sprite = 357,
            color = 3,
            scale = 0.8,
            label = "KMar Garage"
        },
        jobs = {"police", "kmar", "dsi"},
        marker = vector3(42545.1033, 2615.4377, 38.2451),
        deleteMarker = vector3(2539.6169, 2624.1233, 37.9451),
        spawnPoint = {
            coords = vector3(2519.5413, 2626.9241, 37.9451),
            heading = 264.6905
        },
        categories = {
            ["Noodhulp"] = {
                {model = "kmarimperial", label = "Benefactor Imperial", livery = 0, extras = {}}
            },
            ["SIV"] = {
                {model = "kmarargento2", label = "Argento", livery = 0, extras = {}},
                {model = "kmarodyssey", label = "Odyssey", livery = 0, extras = {}}
            },
            ["Offroad"] = {
                {model = "kmareveron", label = "Everon", livery = 0, extras = {}},
                {model = "kmardubstag", label = "Benefactor Dubsta G", livery = 0, extras = {}}
            },
            ["Motoren"] = {
                {model = "kmartroble", label = "Lichte Motor", livery = 0, extras = {}}
            },
            ["Unmarked"] = {
                {model = "swatvanr2", label = "Benefactor Jogger", livery = 0, extras = {}},
                {model = "astronun", label = "Pfister Astronun", livery = 0, extras = {}},
                {model = "sugoi", label = "Sugoi", livery = 0, extras = {}},
                {model = "unkomodai", label = "Lampadati Komodai", livery = 0, extras = {}},
                {model = "unkuruma", label = "Karin Kuruma", livery = 0, extras = {}},
                {model = "ureblahyc", label = "Ubermacht Rebla HYC", livery = 0, extras = {}}
            },
        }
    },
    [3] = {
        name = "Ambulance Garage",
        blip = {
            sprite = 61,
            color = 1,
            scale = 0.8,
            label = "Ambulance Garage"
        },
        jobs = {"ambulance"},
        marker = vector3(299.1283, -579.2250, 43.5609),
        deleteMarker = vector3(288.9333, -592.7184, 43.1719),
        spawnPoint = {
            coords = vector3(292.5873, -583.4554, 43.1939),
            heading = 345.3697
        },
        categories = {
            ["Noodhulp"] = {
                {model = "ambuimperial", label = "Benefactor Imperial", livery = 0, extras = {}},
                {model = "ambujogger", label = "Benefactor Jogger", livery = 0, extras = {}}
            },
            ["Offroad"] = {
                {model = "ambusandstorm", label = "Sandstorm", livery = 0, extras = {}}
            },
            ["Motoren"] = {
                {model = "ambuthrust", label = "Thrust", livery = 0, extras = {}}
            },
            ["SIV"] = {
                {model = "ambuargento", label = "Argento", livery = 0, extras = {}}
            }
        }
    },
    [4] = {
        name = "Monteur Garage",
        blip = {
            sprite = 446,
            color = 5,
            scale = 0.8,
            label = "Monteur Garage"
        },
        jobs = {"mechanic"},
        marker = vector3(539.2762, -184.3468, 54.7853),
        deleteMarker = vector3(533.8959, -183.1553, 54.2191),
        spawnPoint = {
            coords = vector3(535.8134, -174.8586, 54.4675),
            heading = 174.3146
        },
        categories = {
            ["Sleepwagens"] = {
                {model = "flatbed3", label = "Flatbed", livery = 0, extras = {}}
            },
            ["Noodhulp"] = {
                {model = "phimperial", label = "Benefactor Imperial", livery = 0, extras = {}},
                {model = "phriata", label = "Vapid Riata", livery = 0, extras = {}}
            },
            ["Offroad"] = {
                {model = "pheveron", label = "Everon", livery = 0, extras = {}}
            }
        }
    }
}
