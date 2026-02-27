const aws = @import("aws");

/// Configurations used to create a decoder manifest.
pub const CanDbcDefinition = struct {
    /// A list of DBC files. You can upload only one DBC file for each network
    /// interface and
    /// specify up to five (inclusive) files in the list. The DBC file can be a
    /// maximum size of
    /// 200 MB.
    can_dbc_files: []const []const u8,

    /// Contains information about a network interface.
    network_interface: []const u8,

    /// Pairs every signal specified in your vehicle model with a signal decoder.
    signals_map: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .can_dbc_files = "canDbcFiles",
        .network_interface = "networkInterface",
        .signals_map = "signalsMap",
    };
};
