/// Contains information about the resource that is associated with a feed. It
/// is used in the FeedSummary that is used in the response of a ListFeeds
/// action.
pub const FeedAssociation = struct {
    /// The name of the associated resource.
    associated_resource_name: []const u8,

    pub const json_field_names = .{
        .associated_resource_name = "associatedResourceName",
    };
};
