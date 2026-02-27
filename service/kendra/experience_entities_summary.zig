const EntityDisplayData = @import("entity_display_data.zig").EntityDisplayData;
const EntityType = @import("entity_type.zig").EntityType;

/// Summary information for users or groups in your IAM Identity Center identity
/// source with granted access to your Amazon Kendra experience. You can create
/// an Amazon Kendra
/// experience such as a search application. For more information on creating a
/// search application experience, see [Building
/// a search experience with no
/// code](https://docs.aws.amazon.com/kendra/latest/dg/deploying-search-experience-no-code.html).
pub const ExperienceEntitiesSummary = struct {
    /// Information about the user entity.
    display_data: ?EntityDisplayData,

    /// The identifier of a user or group in your IAM Identity Center identity
    /// source.
    /// For example, a user ID could be an email.
    entity_id: ?[]const u8,

    /// Shows the type as `User` or `Group`.
    entity_type: ?EntityType,

    pub const json_field_names = .{
        .display_data = "DisplayData",
        .entity_id = "EntityId",
        .entity_type = "EntityType",
    };
};
