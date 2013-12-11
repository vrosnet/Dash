module graphics.graphicscontroller;
import graphics.adapters.adaptercontroller, graphics.adapters.openglcontroller, graphics.adapters.directxcontroller;

class GraphicsController
{
static
{
public:
	AdapterController getAdapter()
	{
		// if gl
		{
			if( gl is null )
				gl = new OpenGLController();
			return gl;
		}
		// elseif dx
		{
			if( dx is null )
				dx = new DirectXController();
			return dx;
		}
	}

private:
	OpenGLController gl;
	DirectXController dx;
}
}
