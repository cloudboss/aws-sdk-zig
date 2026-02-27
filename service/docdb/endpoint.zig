/// Network information for accessing a cluster or instance. Client programs
/// must
/// specify a valid endpoint to access these Amazon DocumentDB resources.
pub const Endpoint = struct {
    /// Specifies the DNS address of the instance.
    address: ?[]const u8,

    /// Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8,

    /// Specifies the port that the database engine is listening on.
    port: ?i32,
};
