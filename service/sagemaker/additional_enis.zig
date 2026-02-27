/// Information about additional Elastic Network Interfaces (ENIs) associated
/// with an instance.
pub const AdditionalEnis = struct {
    /// A list of Elastic Fabric Adapter (EFA) ENIs associated with the instance.
    efa_enis: ?[]const []const u8,

    pub const json_field_names = .{
        .efa_enis = "EfaEnis",
    };
};
