const std = @import("std");

pub const NetworkInterfaceFailureReason = enum {
    duplicate_interface,
    conflicting_network_interface,
    network_interface_to_add_already_exists,
    can_network_interface_info_is_null,
    obd_network_interface_info_is_null,
    network_interface_to_remove_associated_with_signals,
    vehicle_middleware_network_interface_info_is_null,
    custom_decoding_signal_network_interface_info_is_null,

    pub const json_field_names = .{
        .duplicate_interface = "DUPLICATE_NETWORK_INTERFACE",
        .conflicting_network_interface = "CONFLICTING_NETWORK_INTERFACE",
        .network_interface_to_add_already_exists = "NETWORK_INTERFACE_TO_ADD_ALREADY_EXISTS",
        .can_network_interface_info_is_null = "CAN_NETWORK_INTERFACE_INFO_IS_NULL",
        .obd_network_interface_info_is_null = "OBD_NETWORK_INTERFACE_INFO_IS_NULL",
        .network_interface_to_remove_associated_with_signals = "NETWORK_INTERFACE_TO_REMOVE_ASSOCIATED_WITH_SIGNALS",
        .vehicle_middleware_network_interface_info_is_null = "VEHICLE_MIDDLEWARE_NETWORK_INTERFACE_INFO_IS_NULL",
        .custom_decoding_signal_network_interface_info_is_null = "CUSTOM_DECODING_SIGNAL_NETWORK_INTERFACE_INFO_IS_NULL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_interface => "DUPLICATE_NETWORK_INTERFACE",
            .conflicting_network_interface => "CONFLICTING_NETWORK_INTERFACE",
            .network_interface_to_add_already_exists => "NETWORK_INTERFACE_TO_ADD_ALREADY_EXISTS",
            .can_network_interface_info_is_null => "CAN_NETWORK_INTERFACE_INFO_IS_NULL",
            .obd_network_interface_info_is_null => "OBD_NETWORK_INTERFACE_INFO_IS_NULL",
            .network_interface_to_remove_associated_with_signals => "NETWORK_INTERFACE_TO_REMOVE_ASSOCIATED_WITH_SIGNALS",
            .vehicle_middleware_network_interface_info_is_null => "VEHICLE_MIDDLEWARE_NETWORK_INTERFACE_INFO_IS_NULL",
            .custom_decoding_signal_network_interface_info_is_null => "CUSTOM_DECODING_SIGNAL_NETWORK_INTERFACE_INFO_IS_NULL",
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
