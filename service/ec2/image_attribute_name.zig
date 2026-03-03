const std = @import("std");

pub const ImageAttributeName = enum {
    description,
    kernel,
    ramdisk,
    launch_permission,
    product_codes,
    block_device_mapping,
    sriov_net_support,
    boot_mode,
    tpm_support,
    uefi_data,
    last_launched_time,
    imds_support,
    deregistration_protection,

    pub const json_field_names = .{
        .description = "description",
        .kernel = "kernel",
        .ramdisk = "ramdisk",
        .launch_permission = "launchPermission",
        .product_codes = "productCodes",
        .block_device_mapping = "blockDeviceMapping",
        .sriov_net_support = "sriovNetSupport",
        .boot_mode = "bootMode",
        .tpm_support = "tpmSupport",
        .uefi_data = "uefiData",
        .last_launched_time = "lastLaunchedTime",
        .imds_support = "imdsSupport",
        .deregistration_protection = "deregistrationProtection",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .description => "description",
            .kernel => "kernel",
            .ramdisk => "ramdisk",
            .launch_permission => "launchPermission",
            .product_codes => "productCodes",
            .block_device_mapping => "blockDeviceMapping",
            .sriov_net_support => "sriovNetSupport",
            .boot_mode => "bootMode",
            .tpm_support => "tpmSupport",
            .uefi_data => "uefiData",
            .last_launched_time => "lastLaunchedTime",
            .imds_support => "imdsSupport",
            .deregistration_protection => "deregistrationProtection",
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
