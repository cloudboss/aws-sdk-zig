const DataSourceGroup = @import("data_source_group.zig").DataSourceGroup;

/// Provides information about the user context for an Amazon Kendra index.
///
/// User context filtering is a kind of personalized search with the benefit of
/// controlling
/// access to documents. For example, not all teams that search the company
/// portal for
/// information should access top-secret company documents, nor are these
/// documents relevant to
/// all users. Only specific users or groups of teams given access to top-secret
/// documents
/// should see these documents in their search results.
///
/// You provide one of the following:
///
/// * User token
///
/// * User ID, the groups the user belongs to, and any data sources the groups
///   can
/// access.
///
/// If you provide both, an exception is thrown.
///
/// If you're using an Amazon Kendra Gen AI Enterprise Edition index, you can
/// use
/// `UserId`, `Groups`, and `DataSourceGroups` to filter
/// content. If you set the `UserId` to a particular user ID, it also includes
/// all public documents.
///
/// Amazon Kendra Gen AI Enterprise Edition indices don't support token based
/// document filtering.
/// If you're using an Amazon Kendra Gen AI Enterprise Edition index, Amazon
/// Kendra returns a
/// `ValidationException` error if the `Token` field has a non-null
/// value.
pub const UserContext = struct {
    /// The list of data source groups you want to filter search results based on
    /// groups' access
    /// to documents in that data source.
    data_source_groups: ?[]const DataSourceGroup = null,

    /// The list of groups you want to filter search results based on the groups'
    /// access to
    /// documents.
    groups: ?[]const []const u8 = null,

    /// The user context token for filtering search results for a user. It must be a
    /// JWT or a
    /// JSON token.
    token: ?[]const u8 = null,

    /// The identifier of the user you want to filter search results based on their
    /// access to
    /// documents.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_groups = "DataSourceGroups",
        .groups = "Groups",
        .token = "Token",
        .user_id = "UserId",
    };
};
