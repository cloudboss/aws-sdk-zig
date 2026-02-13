const InstanceInformationFilterKey = @import("instance_information_filter_key.zig").InstanceInformationFilterKey;

/// Describes a filter for a specific list of managed nodes. You can filter node
/// information by
/// using tags. You specify tags by using a key-value mapping.
///
/// Use this operation instead of the
/// DescribeInstanceInformationRequest$InstanceInformationFilterList method. The
/// `InstanceInformationFilterList` method is a legacy method and doesn't
/// support tags.
pub const InstanceInformationFilter = struct {
    /// The name of the filter.
    key: InstanceInformationFilterKey,

    /// The filter values.
    value_set: []const []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value_set = "valueSet",
    };
};
