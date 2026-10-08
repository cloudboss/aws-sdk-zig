/// Metadata for a system service associated event.
pub const SystemServiceAssociatedMetadata = struct {
    service_arn: ?[]const u8 = null,

    /// The name of the associated service.
    service_name: ?[]const u8 = null,

    /// The user journeys linking the service to the system.
    user_journeys: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .service_arn = "serviceArn",
        .service_name = "serviceName",
        .user_journeys = "userJourneys",
    };
};
