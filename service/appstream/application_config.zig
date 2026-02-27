/// Configuration for an application in the imported image's application
/// catalog. This structure defines how applications appear and launch for
/// users.
pub const ApplicationConfig = struct {
    /// The absolute path to the executable file that launches the application. This
    /// is a required field that can be 1-32767 characters to support Windows
    /// extended file paths. Use escaped file path strings like
    /// "C:\\\\Windows\\\\System32\\\\notepad.exe".
    absolute_app_path: []const u8,

    /// The absolute path to the icon file for the application. This field is
    /// optional and can be 1-32767 characters. If not provided, the icon is derived
    /// from the executable. Use PNG images with proper transparency for the best
    /// user experience.
    absolute_icon_path: ?[]const u8,

    /// The absolute path to the prewarm manifest file for this application. This
    /// field is optional and only applicable when using application-specific
    /// manifests. The path can be 1-32767 characters and should point to a text
    /// file containing file paths to prewarm.
    absolute_manifest_path: ?[]const u8,

    /// The display name shown to users for this application. This field is optional
    /// and can be 0-100 characters, matching the pattern ^[a-zA-Z0-9][a-zA-Z0-9_.
    /// -]{0,99}$.
    display_name: ?[]const u8,

    /// The launch parameters to pass to the application executable. This field is
    /// optional and can be 0-1024 characters. Use escaped strings with the full
    /// list of required parameters, such as PowerShell script paths or command-line
    /// arguments.
    launch_parameters: ?[]const u8,

    /// The name of the application. This is a required field that must be unique
    /// within the application catalog and between 1-100 characters, matching the
    /// pattern ^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,99}$.
    name: []const u8,

    /// The working directory to use when launching the application. This field is
    /// optional and can be 0-32767 characters. Use escaped file path strings like
    /// "C:\\\\Path\\\\To\\\\Working\\\\Directory".
    working_directory: ?[]const u8,

    pub const json_field_names = .{
        .absolute_app_path = "AbsoluteAppPath",
        .absolute_icon_path = "AbsoluteIconPath",
        .absolute_manifest_path = "AbsoluteManifestPath",
        .display_name = "DisplayName",
        .launch_parameters = "LaunchParameters",
        .name = "Name",
        .working_directory = "WorkingDirectory",
    };
};
