const std = @import("std");

pub const ServiceError = union(enum) {
    expired_token_exception: ExpiredTokenException,
    expired_trade_in_token_exception: ExpiredTradeInTokenException,
    idp_communication_error_exception: IDPCommunicationErrorException,
    idp_rejected_claim_exception: IDPRejectedClaimException,
    invalid_authorization_message_exception: InvalidAuthorizationMessageException,
    invalid_identity_token_exception: InvalidIdentityTokenException,
    jwt_payload_size_exceeded_exception: JWTPayloadSizeExceededException,
    malformed_policy_document_exception: MalformedPolicyDocumentException,
    outbound_web_identity_federation_disabled_exception: OutboundWebIdentityFederationDisabledException,
    packed_policy_too_large_exception: PackedPolicyTooLargeException,
    region_disabled_exception: RegionDisabledException,
    session_duration_escalation_exception: SessionDurationEscalationException,
    unknown: UnknownServiceError,

    pub fn code(self: ServiceError) []const u8 {
        return switch (self) {
            .expired_token_exception => "ExpiredTokenException",
            .expired_trade_in_token_exception => "ExpiredTradeInTokenException",
            .idp_communication_error_exception => "IDPCommunicationErrorException",
            .idp_rejected_claim_exception => "IDPRejectedClaimException",
            .invalid_authorization_message_exception => "InvalidAuthorizationMessageException",
            .invalid_identity_token_exception => "InvalidIdentityTokenException",
            .jwt_payload_size_exceeded_exception => "JWTPayloadSizeExceededException",
            .malformed_policy_document_exception => "MalformedPolicyDocumentException",
            .outbound_web_identity_federation_disabled_exception => "OutboundWebIdentityFederationDisabledException",
            .packed_policy_too_large_exception => "PackedPolicyTooLargeException",
            .region_disabled_exception => "RegionDisabledException",
            .session_duration_escalation_exception => "SessionDurationEscalationException",
            .unknown => |e| e.code,
        };
    }

    pub fn message(self: ServiceError) []const u8 {
        return switch (self) {
            .expired_token_exception => |e| e.message,
            .expired_trade_in_token_exception => |e| e.message,
            .idp_communication_error_exception => |e| e.message,
            .idp_rejected_claim_exception => |e| e.message,
            .invalid_authorization_message_exception => |e| e.message,
            .invalid_identity_token_exception => |e| e.message,
            .jwt_payload_size_exceeded_exception => |e| e.message,
            .malformed_policy_document_exception => |e| e.message,
            .outbound_web_identity_federation_disabled_exception => |e| e.message,
            .packed_policy_too_large_exception => |e| e.message,
            .region_disabled_exception => |e| e.message,
            .session_duration_escalation_exception => |e| e.message,
            .unknown => |e| e.message,
        };
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return switch (self) {
            .expired_token_exception => 400,
            .expired_trade_in_token_exception => 400,
            .idp_communication_error_exception => 400,
            .idp_rejected_claim_exception => 403,
            .invalid_authorization_message_exception => 400,
            .invalid_identity_token_exception => 400,
            .jwt_payload_size_exceeded_exception => 400,
            .malformed_policy_document_exception => 400,
            .outbound_web_identity_federation_disabled_exception => 403,
            .packed_policy_too_large_exception => 400,
            .region_disabled_exception => 403,
            .session_duration_escalation_exception => 403,
            .unknown => |e| e.http_status,
        };
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return switch (self) {
            .expired_token_exception => |e| e.request_id,
            .expired_trade_in_token_exception => |e| e.request_id,
            .idp_communication_error_exception => |e| e.request_id,
            .idp_rejected_claim_exception => |e| e.request_id,
            .invalid_authorization_message_exception => |e| e.request_id,
            .invalid_identity_token_exception => |e| e.request_id,
            .jwt_payload_size_exceeded_exception => |e| e.request_id,
            .malformed_policy_document_exception => |e| e.request_id,
            .outbound_web_identity_federation_disabled_exception => |e| e.request_id,
            .packed_policy_too_large_exception => |e| e.request_id,
            .region_disabled_exception => |e| e.request_id,
            .session_duration_escalation_exception => |e| e.request_id,
            .unknown => |e| e.request_id,
        };
    }
};

pub const ExpiredTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ExpiredTradeInTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IDPCommunicationErrorException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IDPRejectedClaimException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidAuthorizationMessageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidIdentityTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const JWTPayloadSizeExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MalformedPolicyDocumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OutboundWebIdentityFederationDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PackedPolicyTooLargeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const RegionDisabledException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SessionDurationEscalationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
