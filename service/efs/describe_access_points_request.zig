pub const DescribeAccessPointsRequest = struct {
    /// (Optional) Specifies an EFS access point to describe in the response;
    /// mutually
    /// exclusive with `FileSystemId`.
    access_point_id: ?[]const u8 = null,

    /// (Optional) If you provide a `FileSystemId`, EFS returns all access
    /// points for that file system; mutually exclusive with `AccessPointId`.
    file_system_id: ?[]const u8 = null,

    /// (Optional) When retrieving all access points for a file system,
    /// you can optionally specify the `MaxItems` parameter to limit the number of
    /// objects returned in a response.
    /// The default value is 100.
    max_results: ?i32 = null,

    /// `NextToken` is present if the response is paginated. You can use
    /// `NextMarker` in the subsequent request to fetch the next page of access
    /// point descriptions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_id = "AccessPointId",
        .file_system_id = "FileSystemId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
