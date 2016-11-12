using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SampleApp.Web.Startup))]
namespace SampleApp.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
