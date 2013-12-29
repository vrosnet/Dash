/**
 * Defines the FilePath class, which stores default resource paths, and handles path manipulation.
 */
module utility.filepath;
static import std.file, std.path;

/**
 * A class which stores default resource paths, and handles path manipulation.
 */
class FilePath
{
public:
	/**
	 * The path to the resources home folder.
	 */
	enum ResourceHome = "./Game";

	/**
	 * Paths to the different resource files.
	 */
	enum Resources : string
	{
		Meshes = ResourceHome ~ "/Meshes",
		Textures = ResourceHome ~ "/Textures",
		Scripts = ResourceHome ~ "/Scripts",
		Prefabs = ResourceHome ~ "/Prefabs",
		Objects = ResourceHome ~ "/Objects",
		Shaders = ResourceHome ~ "/Shaders",
		UI = ResourceHome ~ "/UI",
		Config = ResourceHome ~ "/Config.yaml"
	}

	/**
	 * Get all files in a given directory.
	 */
	static FilePath[] scanDirectory( string path, string pattern = "" )
	{
		// Get absolute path to folder
		string safePath = std.path.buildNormalizedPath( std.path.absolutePath( path ) );

		// Start array
		auto files = new FilePath[ 1 ];
		uint filesFound = 0;

		// Add file to array
		void handleFile( string name )
		{
			if( filesFound == files.length )
				files.length *= 2;

			files[ filesFound++ ] = new FilePath( name );
		}

		// Find files
		if( pattern.length )
			foreach( name; std.file.dirEntries( safePath, pattern, std.file.SpanMode.breadth ) )
				handleFile( name );
		else
			foreach( name; std.file.dirEntries( safePath, std.file.SpanMode.breadth ) )
				handleFile( name );

		files.length = filesFound;

		return files;
	}

	/// The full path to the file.
	@property string fullPath()		{ return _fullPath; }
	/// The relative path from the executable to the file.
	@property string relativePath()	{ return std.path.relativePath( _fullPath ); }
	/// The name of the file with its extension.
	@property string fileName()		{ return std.path.baseName( _fullPath ); }
	/// The name of the file without its extension.
	@property string baseFileName()	{ return std.path.stripExtension( _fullPath ); }
	/// The path to the directory containing the file.
	@property string directory()	{ return std.path.dirName( _fullPath ); }
	/// The extensino of the file.
	@property string extension()	{ return std.path.extension( _fullPath ); }

	/**
	 * Create an instance based on a given file path.
	 */
	this( string path )
	{
		if( std.file.isFile( path ) )
			_fullPath = std.path.buildNormalizedPath( std.path.absolutePath( path ) );
		else
			throw new Exception( "Invalid file name." );
	}

private:
	string _fullPath;
}