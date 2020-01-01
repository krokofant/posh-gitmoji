module.exports = {
  pathPrefix: '/posh-gitmoji',
  siteMetadata: {
    title: 'posh-gitmoji - gitmoji in your terminal',
    author: 'Krokofant',
    description:
      'A powershell interactive emoji guide for your commit messages',
  },
  plugins: [
    'gatsby-plugin-react-helmet',
    {
      resolve: `gatsby-plugin-manifest`,
      options: {
        name: 'posh-gitmoji',
        short_name: 'posh-gitmoji',
        start_url: 'https://krokofant.github.io/posh-gitmoji/',
        background_color: '#663399',
        theme_color: '#663399',
        display: 'minimal-ui',
        icon: 'src/assets/images/posh-gitmoji-256.png', // This path is relative to the root of the site.
      },
    },
    'gatsby-plugin-sass',
    'gatsby-plugin-offline',
  ],
}
