const std = @import("std");

pub const OperationType = enum {
    create_namespace,
    delete_namespace,
    update_namespace,
    update_service,
    register_instance,
    deregister_instance,

    pub const json_field_names = .{
        .create_namespace = "CREATE_NAMESPACE",
        .delete_namespace = "DELETE_NAMESPACE",
        .update_namespace = "UPDATE_NAMESPACE",
        .update_service = "UPDATE_SERVICE",
        .register_instance = "REGISTER_INSTANCE",
        .deregister_instance = "DEREGISTER_INSTANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_namespace => "CREATE_NAMESPACE",
            .delete_namespace => "DELETE_NAMESPACE",
            .update_namespace => "UPDATE_NAMESPACE",
            .update_service => "UPDATE_SERVICE",
            .register_instance => "REGISTER_INSTANCE",
            .deregister_instance => "DEREGISTER_INSTANCE",
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
