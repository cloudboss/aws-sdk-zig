const std = @import("std");

pub const InstanceAttributeName = enum {
    instance_type,
    kernel,
    ramdisk,
    user_data,
    disable_api_termination,
    instance_initiated_shutdown_behavior,
    root_device_name,
    block_device_mapping,
    product_codes,
    source_dest_check,
    group_set,
    ebs_optimized,
    sriov_net_support,
    ena_support,
    enclave_options,
    disable_api_stop,

    pub const json_field_names = .{
        .instance_type = "instanceType",
        .kernel = "kernel",
        .ramdisk = "ramdisk",
        .user_data = "userData",
        .disable_api_termination = "disableApiTermination",
        .instance_initiated_shutdown_behavior = "instanceInitiatedShutdownBehavior",
        .root_device_name = "rootDeviceName",
        .block_device_mapping = "blockDeviceMapping",
        .product_codes = "productCodes",
        .source_dest_check = "sourceDestCheck",
        .group_set = "groupSet",
        .ebs_optimized = "ebsOptimized",
        .sriov_net_support = "sriovNetSupport",
        .ena_support = "enaSupport",
        .enclave_options = "enclaveOptions",
        .disable_api_stop = "disableApiStop",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_type => "instanceType",
            .kernel => "kernel",
            .ramdisk => "ramdisk",
            .user_data => "userData",
            .disable_api_termination => "disableApiTermination",
            .instance_initiated_shutdown_behavior => "instanceInitiatedShutdownBehavior",
            .root_device_name => "rootDeviceName",
            .block_device_mapping => "blockDeviceMapping",
            .product_codes => "productCodes",
            .source_dest_check => "sourceDestCheck",
            .group_set => "groupSet",
            .ebs_optimized => "ebsOptimized",
            .sriov_net_support => "sriovNetSupport",
            .ena_support => "enaSupport",
            .enclave_options => "enclaveOptions",
            .disable_api_stop => "disableApiStop",
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
