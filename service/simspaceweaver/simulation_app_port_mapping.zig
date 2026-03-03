/// A collection of TCP/UDP ports for a custom or service app.
pub const SimulationAppPortMapping = struct {
    /// The TCP/UDP port number of the running app. SimSpace Weaver dynamically
    /// assigns this port
    /// number when the app starts. SimSpace Weaver maps the `Declared` port to the
    /// `Actual` port. Clients connect to the app using the app's IP address
    /// and the `Actual` port number.
    actual: ?i32 = null,

    /// The TCP/UDP port number of the app, declared in the simulation schema.
    /// SimSpace Weaver maps
    /// the `Declared` port to the `Actual` port. The source code for the
    /// app should bind to the `Declared` port.
    declared: ?i32 = null,

    pub const json_field_names = .{
        .actual = "Actual",
        .declared = "Declared",
    };
};
