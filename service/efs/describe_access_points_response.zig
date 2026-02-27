const AccessPointDescription = @import("access_point_description.zig").AccessPointDescription;

pub const DescribeAccessPointsResponse = struct {
    /// An array of access point descriptions.
    access_points: ?[]const AccessPointDescription,

    /// Present if there are more access points than returned in the response.
    /// You can use the NextMarker in the subsequent request to fetch the additional
    /// descriptions.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .next_token = "NextToken",
    };
};
