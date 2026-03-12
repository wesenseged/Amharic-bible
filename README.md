<p align="center">
<img width="128" src="https://wesen.vercel.app/projects/Ebible.png" alt="App icon"/>
</p>

<h1 align="center">Amharic Bible</h1>

<p align="center"> 
A modern Amharic Bible reader built with Kirigami and Qt 6 — beautiful, fast, and offline.
</p>

<p align="center">
    <a href='https://flathub.org/apps/io.github.wesenseged.Amharic-bible'><img width='190' alt='Download on Flathub' src='https://flathub.org/api/badge?locale=en'/></a><br><br>
</p>


| ![Screenie 1](https://raw.githubusercontent.com/wesenseged/Amharic-bible/main/screenshots/book-selector.png) | ![Screenie 2](https://raw.githubusercontent.com/wesenseged/Amharic-bible/main/screenshots/main-view.png) |
|:---------------------------------------------------------------:|:---------------------------------------------------------------:|
| ![Screenie 3](https://raw.githubusercontent.com/wesenseged/Amharic-bible/main/screenshots/book-selectorw.png) | ![Screenie 4](https://raw.githubusercontent.com/wesenseged/Amharic-bible/main/screenshots/main-vieww.png) |

## Installation

> [!TIP]
> You may need to [install Flatpak and add the Flathub repository](https://flathub.org/setup) if you haven't already.

### Flathub

Use your system's app store to find Amharic Bible or run this command to install it.

```BASH
flatpak install flathub io.github.wesenseged.Amharic-bible
```

##### Compiling manually

Before proceeding, ensure that you have the necessary packages installed for Qt 6 and KDE Frameworks.

```Bash
git clone https://github.com/wesenseged/Amharic-bible
cd Amharic-bible

cmake -B build/ --install-prefix ~/.local
cmake --build build/
cmake --install build/
amharic-bible
```

To uninstall:
```BASH
cmake --build build/ --target uninstall

```
---

## Features

- Full Amharic Bible text
- Clean navigation between books and chapters
- Search
- Adjustable font size

-  Fully offline

---
## License

- **Code & assets** is licensed under the **GNU General Public License v3.0 or later (GPL-3.0-or-later)**.
See the [LICENSES/GPL-3.0-or-later.txt](LICENSES/GPL-3.0-or-later.txt) file for more details.
- **Bible Text:** © [WordProject](https://www.wordproject.org) - used with permission.
Redistribution of the text outside this application is **not permitted**.

---

## Credits
* **Inspiration, Design & Source Text:** [WordProject.org](https://wordproject.org)
---

## Contributing

Contributions, translations, and feedback are welcome!
If you find a bug or want to suggest a feature, please [open an issue](https://github.com/wesenseged/Amharic-bible/issues).

> 🕊️ *“The word of God is living and active.” -- Hebrews 4:12*
