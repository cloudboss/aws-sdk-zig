const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        direct_connect_client_exception: DirectConnectClientException,
        direct_connect_server_exception: DirectConnectServerException,
        duplicate_tag_keys_exception: DuplicateTagKeysException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .direct_connect_client_exception => "DirectConnectClientException",
                .direct_connect_server_exception => "DirectConnectServerException",
                .duplicate_tag_keys_exception => "DuplicateTagKeysException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .direct_connect_client_exception => |e| e.message,
                .direct_connect_server_exception => |e| e.message,
                .duplicate_tag_keys_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .direct_connect_client_exception => 400,
                .direct_connect_server_exception => 500,
                .duplicate_tag_keys_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .direct_connect_client_exception => |e| e.request_id,
                .direct_connect_server_exception => |e| e.request_id,
                .duplicate_tag_keys_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

pub const DirectConnectClientException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DirectConnectServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateTagKeysException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
