/// Enumeration of the policies to enact on existing campaigns during instance
/// config deletion
pub const CampaignDeletionPolicy = enum {
    retain_all,
    delete_all,

    pub const json_field_names = .{
        .retain_all = "RETAIN_ALL",
        .delete_all = "DELETE_ALL",
    };
};
