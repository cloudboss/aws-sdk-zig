const std = @import("std");

/// The status of the Amazon Machine Image (AMI) version for the HyperPod
/// cluster instance group, node, or cluster. The AMI version is determined at
/// the instance group level, and all nodes within an instance group run the
/// same AMI. The cluster-level status is aggregated across all instance groups.
///
/// * `UpToDate`: The resource is running the latest available AMI version.
/// * `UpdateAvailable`: A newer AMI version is available for the resource.
/// * `SecurityUpdateRequired`: The current AMI has known security
///   vulnerabilities, and a patched version is available.
/// * `EndOfLife`: The AMI variant has reached end of support and an upgrade is
///   required.
pub const ClusterImageVersionStatus = enum {
    up_to_date,
    update_available,
    security_update_required,
    end_of_life,

    pub const json_field_names = .{
        .up_to_date = "UpToDate",
        .update_available = "UpdateAvailable",
        .security_update_required = "SecurityUpdateRequired",
        .end_of_life = "EndOfLife",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .up_to_date => "UpToDate",
            .update_available => "UpdateAvailable",
            .security_update_required => "SecurityUpdateRequired",
            .end_of_life => "EndOfLife",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
