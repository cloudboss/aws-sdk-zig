/// Status information for cross-account discovery service.
pub const CrossAccountDiscoveryServiceStatus = struct {
    /// Status message for cross-account discovery service.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
