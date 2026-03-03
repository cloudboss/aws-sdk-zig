const std = @import("std");

pub const PricingPlan = enum {
    /// This pricing plan should be used for request based billing.
    request_based_usage,
    /// This pricing plan must be picked for mobile asset tracking use cases.
    mobile_asset_tracking,
    /// This pricing plan must be picked for mobile asset management use cases
    mobile_asset_management,

    pub const json_field_names = .{
        .request_based_usage = "RequestBasedUsage",
        .mobile_asset_tracking = "MobileAssetTracking",
        .mobile_asset_management = "MobileAssetManagement",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request_based_usage => "RequestBasedUsage",
            .mobile_asset_tracking => "MobileAssetTracking",
            .mobile_asset_management => "MobileAssetManagement",
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
