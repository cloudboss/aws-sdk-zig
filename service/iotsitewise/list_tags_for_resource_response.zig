const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The list of key-value pairs that contain metadata for the resource. For more
    /// information,
    /// see [Tagging your IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
