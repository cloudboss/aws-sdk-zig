/// The destination configuration.
pub const DestinationConfig = struct {
    /// A list of service names that identify the target application. The IoT client
    /// running on the destination device reads this value and uses it to look up a
    /// port or an
    /// IP address and a port. The IoT client instantiates the local proxy, which
    /// uses this
    /// information to connect to the destination application.
    services: []const []const u8,

    /// The name of the IoT thing to which you want to connect.
    thing_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .services = "services",
        .thing_name = "thingName",
    };
};
