const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        add_flow_outputs_420_exception: AddFlowOutputs420Exception,
        bad_request_exception: BadRequestException,
        conflict_exception: ConflictException,
        create_bridge_420_exception: CreateBridge420Exception,
        create_flow_420_exception: CreateFlow420Exception,
        create_gateway_420_exception: CreateGateway420Exception,
        forbidden_exception: ForbiddenException,
        grant_flow_entitlements_420_exception: GrantFlowEntitlements420Exception,
        internal_server_error_exception: InternalServerErrorException,
        not_found_exception: NotFoundException,
        router_input_service_quota_exceeded_exception: RouterInputServiceQuotaExceededException,
        router_network_interface_service_quota_exceeded_exception: RouterNetworkInterfaceServiceQuotaExceededException,
        router_output_service_quota_exceeded_exception: RouterOutputServiceQuotaExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_requests_exception: TooManyRequestsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .add_flow_outputs_420_exception => "AddFlowOutputs420Exception",
                .bad_request_exception => "BadRequestException",
                .conflict_exception => "ConflictException",
                .create_bridge_420_exception => "CreateBridge420Exception",
                .create_flow_420_exception => "CreateFlow420Exception",
                .create_gateway_420_exception => "CreateGateway420Exception",
                .forbidden_exception => "ForbiddenException",
                .grant_flow_entitlements_420_exception => "GrantFlowEntitlements420Exception",
                .internal_server_error_exception => "InternalServerErrorException",
                .not_found_exception => "NotFoundException",
                .router_input_service_quota_exceeded_exception => "RouterInputServiceQuotaExceededException",
                .router_network_interface_service_quota_exceeded_exception => "RouterNetworkInterfaceServiceQuotaExceededException",
                .router_output_service_quota_exceeded_exception => "RouterOutputServiceQuotaExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_requests_exception => "TooManyRequestsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .add_flow_outputs_420_exception => |e| e.message,
                .bad_request_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .create_bridge_420_exception => |e| e.message,
                .create_flow_420_exception => |e| e.message,
                .create_gateway_420_exception => |e| e.message,
                .forbidden_exception => |e| e.message,
                .grant_flow_entitlements_420_exception => |e| e.message,
                .internal_server_error_exception => |e| e.message,
                .not_found_exception => |e| e.message,
                .router_input_service_quota_exceeded_exception => |e| e.message,
                .router_network_interface_service_quota_exceeded_exception => |e| e.message,
                .router_output_service_quota_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .add_flow_outputs_420_exception => 420,
                .bad_request_exception => 400,
                .conflict_exception => 409,
                .create_bridge_420_exception => 420,
                .create_flow_420_exception => 420,
                .create_gateway_420_exception => 420,
                .forbidden_exception => 403,
                .grant_flow_entitlements_420_exception => 420,
                .internal_server_error_exception => 500,
                .not_found_exception => 404,
                .router_input_service_quota_exceeded_exception => 420,
                .router_network_interface_service_quota_exceeded_exception => 420,
                .router_output_service_quota_exceeded_exception => 420,
                .service_unavailable_exception => 503,
                .too_many_requests_exception => 429,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .add_flow_outputs_420_exception => |e| e.request_id,
                .bad_request_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .create_bridge_420_exception => |e| e.request_id,
                .create_flow_420_exception => |e| e.request_id,
                .create_gateway_420_exception => |e| e.request_id,
                .forbidden_exception => |e| e.request_id,
                .grant_flow_entitlements_420_exception => |e| e.request_id,
                .internal_server_error_exception => |e| e.request_id,
                .not_found_exception => |e| e.request_id,
                .router_input_service_quota_exceeded_exception => |e| e.request_id,
                .router_network_interface_service_quota_exceeded_exception => |e| e.request_id,
                .router_output_service_quota_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

pub const AddFlowOutputs420Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateBridge420Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateFlow420Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateGateway420Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ForbiddenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GrantFlowEntitlements420Exception = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RouterInputServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RouterNetworkInterfaceServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RouterOutputServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
