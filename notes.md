https://krokofant.github.io/gitmoji/?unicode

```javascript
copy(
  $$(".emoji-card")
    .map(e => {
      const desc = e.querySelector(".emoji-info p").innerText;
      const icon = e.querySelector(".emoji-icon.gitmoji");
      let code = icon.dataset.clipboardText;
      code = code.substring(1, code.length - 1);
      const emoji = icon.textContent;
      return `
@{emoji = "${emoji}"; code = "${code}"; desc = "${desc}"}
`.trim();
    })
    .join(",\n")
);
```
