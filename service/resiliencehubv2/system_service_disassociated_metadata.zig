/// Metadata for a system service disassociated event.
pub const SystemServiceDisassociatedMetadata = struct {
    /// A comment about the disassociation.
    comment: ?[]const u8 = null,

    service_arn: ?[]const u8 = null,

    /// The name of the disassociated service.
    service_name: ?[]const u8 = null,

    /// The user journeys affected by the disassociation.
    user_journeys_affected: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .comment = "comment",
        .service_arn = "serviceArn",
        .service_name = "serviceName",
        .user_journeys_affected = "userJourneysAffected",
    };
};
