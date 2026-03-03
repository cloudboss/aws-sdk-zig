const std = @import("std");

pub const IpAddressStatus = enum {
    creating,
    failed_creation,
    attaching,
    attached,
    remap_detaching,
    remap_attaching,
    detaching,
    failed_resource_gone,
    deleting,
    delete_failed_fas_expired,
    updating,
    update_failed,
    isolated,

    pub const json_field_names = .{
        .creating = "CREATING",
        .failed_creation = "FAILED_CREATION",
        .attaching = "ATTACHING",
        .attached = "ATTACHED",
        .remap_detaching = "REMAP_DETACHING",
        .remap_attaching = "REMAP_ATTACHING",
        .detaching = "DETACHING",
        .failed_resource_gone = "FAILED_RESOURCE_GONE",
        .deleting = "DELETING",
        .delete_failed_fas_expired = "DELETE_FAILED_FAS_EXPIRED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .isolated = "ISOLATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "CREATING",
            .failed_creation => "FAILED_CREATION",
            .attaching => "ATTACHING",
            .attached => "ATTACHED",
            .remap_detaching => "REMAP_DETACHING",
            .remap_attaching => "REMAP_ATTACHING",
            .detaching => "DETACHING",
            .failed_resource_gone => "FAILED_RESOURCE_GONE",
            .deleting => "DELETING",
            .delete_failed_fas_expired => "DELETE_FAILED_FAS_EXPIRED",
            .updating => "UPDATING",
            .update_failed => "UPDATE_FAILED",
            .isolated => "ISOLATED",
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
