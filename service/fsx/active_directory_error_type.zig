const std = @import("std");

/// The type of error relating to Microsoft Active Directory. NOT_FOUND means
/// that no
/// directory was found by specifying the given directory. INCOMPATIBLE_MODE
/// means that the
/// directory specified is not a Microsoft AD directory. WRONG_VPC means that
/// the specified
/// directory isn't accessible from the specified VPC. WRONG_STAGE means that
/// the
/// specified directory isn't currently in the ACTIVE state.
pub const ActiveDirectoryErrorType = enum {
    domain_not_found,
    incompatible_domain_mode,
    wrong_vpc,
    invalid_network_type,
    invalid_domain_stage,

    pub const json_field_names = .{
        .domain_not_found = "DOMAIN_NOT_FOUND",
        .incompatible_domain_mode = "INCOMPATIBLE_DOMAIN_MODE",
        .wrong_vpc = "WRONG_VPC",
        .invalid_network_type = "INVALID_NETWORK_TYPE",
        .invalid_domain_stage = "INVALID_DOMAIN_STAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .domain_not_found => "DOMAIN_NOT_FOUND",
            .incompatible_domain_mode => "INCOMPATIBLE_DOMAIN_MODE",
            .wrong_vpc => "WRONG_VPC",
            .invalid_network_type => "INVALID_NETWORK_TYPE",
            .invalid_domain_stage => "INVALID_DOMAIN_STAGE",
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
