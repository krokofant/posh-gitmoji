import React from 'react'

import logo from '../assets/images/posh-gitmoji-160.png'

const Header = props => (
  <header id="header" className="alt">
    <span className="logo">
      <img src={logo} alt="" />
    </span>
    <h1>posh-gitmoji</h1>
    <p>A powershell interactive emoji guide for your commit messages</p>
  </header>
)

export default Header
