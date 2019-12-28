import React from 'react'
import Helmet from 'react-helmet'
import { Waypoint } from 'react-waypoint'
import gitmojiCommands01 from '../assets/images/gitmoji-commands.png'
import poop from '../assets/images/gitmojis/poop.png'
import rocket from '../assets/images/gitmojis/rocket.png'
import refactor from '../assets/images/gitmojis/refactor.png'
import Header from '../components/Header'
import Layout from '../components/layout'
import Nav from '../components/Nav'

const Command = ({ bin }) => (
  <span
    style={{
      color: 'rgb(207, 163, 21)',
    }}
  >
    {bin}
  </span>
)

class Index extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      stickyNav: false,
    }
  }

  _handleWaypointEnter = () => {
    this.setState(() => ({ stickyNav: false }))
  }

  _handleWaypointLeave = () => {
    this.setState(() => ({ stickyNav: true }))
  }

  render() {
    return (
      <Layout>
        <Helmet title="posh-gitmoji - 🚀" />

        <Header />

        <Waypoint
          onEnter={this._handleWaypointEnter}
          onLeave={this._handleWaypointLeave}
        ></Waypoint>
        <Nav sticky={this.state.stickyNav} />

        <div id="main">
          <section id="intro" className="main">
            <div className="spotlight">
              <div className="content">
                <header className="major">
                  <h2>
                    Getting started{' '}
                    <span role="img" aria-label="peace emoji">
                      🖖
                    </span>
                  </h2>
                </header>
                <p>
                  posh-gitmoji makes it easier to use{' '}
                  <a
                    href="https://gitmoji.carloscuesta.me/"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    gitmoji
                  </a>{' '}
                  in your terminal. It work's best with the{' '}
                  <a
                    href="https://github.com/microsoft/terminal"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    Windows Terminal
                  </a>{' '}
                  for it's emoji support so you can see the emojis rendered
                  before you make your commits.
                </p>
                <p>
                  You can install posh-gitmoji directly from the PSGallery
                  repository:
                  <br />
                  <code>
                    <Command bin="Install-Module" /> posh-gitmoji
                  </code>
                  <br />
                  Type
                  <code>
                    <Command bin="gitmoji" />
                  </code>
                  and
                  <code>&lt;tab&gt;</code>to autocomplete any gitmoji
                </p>
                <p>
                  When autocompleting the command will show the gitmoji and a
                  comment. The comment will not be committed but is only there
                  to give you context. Examples: <br />
                  <code>
                    <Command bin="gitmoji " /> 🔥{' '}
                    <span style={{ color: 'rgb(37, 122, 1)' }}>
                      &lt;# Removing code or files. #&gt;
                    </span>
                  </code>
                  <br />
                  <code>
                    <Command bin="gitmoji " /> 🐛{' '}
                    <span style={{ color: 'rgb(37, 122, 1)' }}>
                      &lt;# Fixing a bug. #&gt;
                    </span>
                  </code>
                  <br />
                  <code>
                    <Command bin="gitmoji " /> 🚑{' '}
                    <span style={{ color: 'rgb(37, 122, 1)' }}>
                      &lt;# Critical hotfix. #&gt;
                    </span>
                  </code>
                </p>
                <p>
                  To view everything the gitmoji cli accepts run
                  <code>
                    <Command bin="help" /> gitmoji
                  </code>
                </p>
              </div>
              <span className="image">
                <img src={gitmojiCommands01} alt="" />
              </span>
            </div>
          </section>

          <section id="first" className="main special">
            <header className="major">
              <h2>What have you done?</h2>
            </header>
            <ul className="features">
              <li>
                <span className="image style01">
                  <img src={rocket} alt="" />
                </span>

                <h3>Deploying stuff</h3>
                <p>
                  <code>
                    <Command bin="gitmoji " />
                    deploy&lt;tab&gt;
                  </code>
                  <br />
                  <code>
                    <Command bin="gitmoji " /> 🚀
                  </code>
                </p>
              </li>
              <li>
                <span className="image style01">
                  <img src={poop} alt="" />
                </span>
                <h3>Writing bad code that needs to be improved</h3>
                <p>
                  <code>
                    <Command bin="gitmoji " />
                    poop&lt;tab&gt;
                  </code>
                  <br />
                  <code>
                    <Command bin="gitmoji " />
                    💩
                  </code>
                </p>
              </li>
              <li>
                <span className="image style01">
                  <img src={refactor} alt="" />
                </span>
                <h3>Refactoring code</h3>
                <p>
                  <code>
                    <Command bin="gitmoji " /> refac&lt;tab&gt;
                  </code>
                  <br />
                  <code>
                    <Command bin="gitmoji " /> ♻
                  </code>
                </p>
              </li>
            </ul>
          </section>

          <section id="second" className="main">
            <header className="major">
              <h2>Configuration</h2>
              <p>
                To make posh-gitmoji work perfectly you might need to configure
                your environment a bit.
              </p>
            </header>
            <h3>
              <i>git log</i> on Windows
            </h3>
            <p className="">
              To make git use utf8 on Windows you can add this to your
              PowerShell profile <code>$env:LC_ALL='C.UTF-8'</code>(
              <a
                href="https://stackoverflow.com/a/41441828"
                target="_blank"
                rel="noopener noreferrer"
              >
                source
              </a>
              )
            </p>
            <h3 id="az_devops">Azure DevOps completion</h3>
            <p>
              Make sure to login with the azure cli <code>az login</code> and
              then configure your default organization and project: <br />
              <textarea readOnly>
                az devops configure --defaults organization=$(Read-Host
                DefaultOrganizationURL) project=$(Read-Host DefaultProjectName)
              </textarea>
              then you can setup your (gitmoji) default AreaPath for Azure
              DevOps <code>gitmoji -AreaPath Example\Area</code>
            </p>
          </section>
        </div>
      </Layout>
    )
  }
}

export default Index
