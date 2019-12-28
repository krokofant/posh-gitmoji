import React from 'react'

const Footer = props => (
  <footer id="footer">
    <section>
      <h2>About</h2>
      <p>
        posh-gitmoji was made to make it easier to use the brilliant
        gitmoji-style categorization for your commit messages.
      </p>
    </section>
    <section>
      <ul className="icons">
        <li>
          <a
            href="https://github.com/krokofant/posh-gitmoji"
            className="icon fa-github alt"
          >
            <span className="label">GitHub</span>
          </a>
        </li>
      </ul>
    </section>
    <p className="copyright">
      &copy; posh-gitmoji. Design: <a href="https://html5up.net">HTML5 UP</a>.
    </p>
  </footer>
)

export default Footer
