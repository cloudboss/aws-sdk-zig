/// A filter for narrowing down service lifecycle results.
pub const ServiceLifecycleFilter = struct {
    /// The Amazon Web Services service name to filter by.
    service: ?[]const u8 = null,

    pub const json_field_names = .{
        .service = "service",
    };
};
