const Application = @import("application.zig").Application;

pub const ListApplicationsResponse = struct {
    /// Retrieves all applications associated with the instance.
    applications: ?[]const Application,

    /// If present, this value indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter in a subsequent call to the operation to get the next part of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .applications = "Applications",
        .next_token = "NextToken",
    };
};
