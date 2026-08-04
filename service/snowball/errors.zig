const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        cluster_limit_exceeded_exception: ClusterLimitExceededException,
        conflict_exception: ConflictException,
        ec_2_request_failed_exception: Ec2RequestFailedException,
        invalid_address_exception: InvalidAddressException,
        invalid_input_combination_exception: InvalidInputCombinationException,
        invalid_job_state_exception: InvalidJobStateException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_resource_exception: InvalidResourceException,
        kms_request_failed_exception: KMSRequestFailedException,
        return_shipping_label_already_exists_exception: ReturnShippingLabelAlreadyExistsException,
        unsupported_address_exception: UnsupportedAddressException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .cluster_limit_exceeded_exception => "ClusterLimitExceededException",
                .conflict_exception => "ConflictException",
                .ec_2_request_failed_exception => "Ec2RequestFailedException",
                .invalid_address_exception => "InvalidAddressException",
                .invalid_input_combination_exception => "InvalidInputCombinationException",
                .invalid_job_state_exception => "InvalidJobStateException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_resource_exception => "InvalidResourceException",
                .kms_request_failed_exception => "KMSRequestFailedException",
                .return_shipping_label_already_exists_exception => "ReturnShippingLabelAlreadyExistsException",
                .unsupported_address_exception => "UnsupportedAddressException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .cluster_limit_exceeded_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .ec_2_request_failed_exception => |e| e.message,
                .invalid_address_exception => |e| e.message,
                .invalid_input_combination_exception => |e| e.message,
                .invalid_job_state_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_resource_exception => |e| e.message,
                .kms_request_failed_exception => |e| e.message,
                .return_shipping_label_already_exists_exception => |e| e.message,
                .unsupported_address_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .cluster_limit_exceeded_exception => 400,
                .conflict_exception => 400,
                .ec_2_request_failed_exception => 400,
                .invalid_address_exception => 400,
                .invalid_input_combination_exception => 400,
                .invalid_job_state_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_resource_exception => 400,
                .kms_request_failed_exception => 400,
                .return_shipping_label_already_exists_exception => 400,
                .unsupported_address_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .cluster_limit_exceeded_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .ec_2_request_failed_exception => |e| e.request_id,
                .invalid_address_exception => |e| e.request_id,
                .invalid_input_combination_exception => |e| e.request_id,
                .invalid_job_state_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_resource_exception => |e| e.request_id,
                .kms_request_failed_exception => |e| e.request_id,
                .return_shipping_label_already_exists_exception => |e| e.request_id,
                .unsupported_address_exception => |e| e.request_id,
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

/// Job creation failed. Currently, clusters support five nodes. If you have
/// fewer than
/// five nodes for your cluster and you have more nodes to create for this
/// cluster, try again and
/// create jobs until your cluster has exactly five nodes.
pub const ClusterLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You get this exception when you call `CreateReturnShippingLabel` more than
/// once
/// when other requests are not completed.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// You get this resource when you call `CreateReturnShippingLabel` more than
    /// once when other requests are not completed. .
    conflict_resource: ?[]const u8 = null,

    pub const json_field_names = .{
        .conflict_resource = "ConflictResource",
        .message = "Message",
    };
};

/// Your user lacks the necessary Amazon EC2 permissions to perform the
/// attempted
/// action.
pub const Ec2RequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The address provided was invalid. Check the address with your region's
/// carrier, and try
/// again.
pub const InvalidAddressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Job or cluster creation failed. One or more inputs were invalid. Confirm
/// that the CreateClusterRequest$SnowballType value supports your
/// CreateJobRequest$JobType, and try again.
pub const InvalidInputCombinationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The action can't be performed because the job's current state doesn't allow
/// that action
/// to be performed.
pub const InvalidJobStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The `NextToken` string was altered unexpectedly, and the operation has
/// stopped. Run the operation without changing the `NextToken` string, and try
/// again.
pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified resource can't be found. Check the information you provided in
/// your last
/// request, and try again.
pub const InvalidResourceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The provided resource value is invalid.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .resource_type = "ResourceType",
    };
};

/// The provided Key Management Service key lacks the permissions to perform the
/// specified
/// CreateJob or UpdateJob action.
pub const KMSRequestFailedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You get this exception if you call `CreateReturnShippingLabel` and a valid
/// return shipping label already exists. In this case, use
/// `DescribeReturnShippingLabel` to get the URL.
pub const ReturnShippingLabelAlreadyExistsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The address is either outside the serviceable area for your region, or an
/// error
/// occurred. Check the address with your region's carrier and try again. If the
/// issue persists,
/// contact Amazon Web Services Support.
pub const UnsupportedAddressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
