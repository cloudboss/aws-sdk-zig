const std = @import("std");

/// The status of the Amazon Machine Image (AMI) version for the HyperPod
/// cluster instance group, node, or cluster. The AMI version is determined at
/// the instance group level, and all nodes within an instance group run the
/// same AMI. The cluster-level status is aggregated across all instance groups.
///
/// * `UpToDate`: The resource is running the latest available AMI version.
/// * `UpdateAvailable`: A newer AMI version is available for the resource.
pub const ClusterImageVersionStatus = enum {
    up_to_date,
    update_available,

    pub const json_field_names = .{
        .up_to_date = "UpToDate",
        .update_available = "UpdateAvailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .up_to_date => "UpToDate",
            .update_available => "UpdateAvailable",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
