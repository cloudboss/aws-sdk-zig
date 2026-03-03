const aws = @import("aws");

const MethodSnapshot = @import("method_snapshot.zig").MethodSnapshot;

/// An immutable representation of a RestApi resource that can be called by
/// users using Stages. A deployment must be associated with a Stage for it to
/// be callable over the Internet.
pub const Deployment = struct {
    /// A summary of the RestApi at the date and time that the deployment resource
    /// was created.
    api_summary: ?[]const aws.map.MapEntry([]const aws.map.MapEntry(MethodSnapshot)) = null,

    /// The date and time that the deployment resource was created.
    created_date: ?i64 = null,

    /// The description for the deployment resource.
    description: ?[]const u8 = null,

    /// The identifier for the deployment resource.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_summary = "apiSummary",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
    };
};
