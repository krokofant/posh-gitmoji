import React from 'react'
import Scrollspy from 'react-scrollspy'
import Scroll from './Scroll'

const Nav = props => (
  <nav id="nav" className={props.sticky ? 'alt' : ''}>
    <Scrollspy
      items={['intro', 'first', 'second', 'az_devops']}
      currentClassName="is-active"
      offset={-300}
    >
      <li>
        <Scroll type="id" element="intro">
          <a href="#">Getting started</a>
        </Scroll>
      </li>
      <li>
        <Scroll type="id" element="first">
          <a href="#">What have you done?</a>
        </Scroll>
      </li>
      <li>
        <Scroll type="id" element="second">
          <a href="#">Configuration</a>
        </Scroll>
      </li>
      <li>
        <Scroll type="id" element="az_devops">
          <a href="#">Azure DevOps completion</a>
        </Scroll>
      </li>
    </Scrollspy>
  </nav>
)

export default Nav
