const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        conflict_exception: ConflictException,
        create_chime_webhook_configuration_exception: CreateChimeWebhookConfigurationException,
        create_slack_channel_configuration_exception: CreateSlackChannelConfigurationException,
        create_teams_channel_configuration_exception: CreateTeamsChannelConfigurationException,
        delete_chime_webhook_configuration_exception: DeleteChimeWebhookConfigurationException,
        delete_microsoft_teams_user_identity_exception: DeleteMicrosoftTeamsUserIdentityException,
        delete_slack_channel_configuration_exception: DeleteSlackChannelConfigurationException,
        delete_slack_user_identity_exception: DeleteSlackUserIdentityException,
        delete_slack_workspace_authorization_fault: DeleteSlackWorkspaceAuthorizationFault,
        delete_teams_channel_configuration_exception: DeleteTeamsChannelConfigurationException,
        delete_teams_configured_team_exception: DeleteTeamsConfiguredTeamException,
        describe_chime_webhook_configurations_exception: DescribeChimeWebhookConfigurationsException,
        describe_slack_channel_configurations_exception: DescribeSlackChannelConfigurationsException,
        describe_slack_user_identities_exception: DescribeSlackUserIdentitiesException,
        describe_slack_workspaces_exception: DescribeSlackWorkspacesException,
        get_account_preferences_exception: GetAccountPreferencesException,
        get_teams_channel_configuration_exception: GetTeamsChannelConfigurationException,
        internal_service_error: InternalServiceError,
        invalid_parameter_exception: InvalidParameterException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        list_microsoft_teams_configured_teams_exception: ListMicrosoftTeamsConfiguredTeamsException,
        list_microsoft_teams_user_identities_exception: ListMicrosoftTeamsUserIdentitiesException,
        list_teams_channel_configurations_exception: ListTeamsChannelConfigurationsException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_tags_exception: TooManyTagsException,
        unauthorized_exception: UnauthorizedException,
        update_account_preferences_exception: UpdateAccountPreferencesException,
        update_chime_webhook_configuration_exception: UpdateChimeWebhookConfigurationException,
        update_slack_channel_configuration_exception: UpdateSlackChannelConfigurationException,
        update_teams_channel_configuration_exception: UpdateTeamsChannelConfigurationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => "ConflictException",
                .create_chime_webhook_configuration_exception => "CreateChimeWebhookConfigurationException",
                .create_slack_channel_configuration_exception => "CreateSlackChannelConfigurationException",
                .create_teams_channel_configuration_exception => "CreateTeamsChannelConfigurationException",
                .delete_chime_webhook_configuration_exception => "DeleteChimeWebhookConfigurationException",
                .delete_microsoft_teams_user_identity_exception => "DeleteMicrosoftTeamsUserIdentityException",
                .delete_slack_channel_configuration_exception => "DeleteSlackChannelConfigurationException",
                .delete_slack_user_identity_exception => "DeleteSlackUserIdentityException",
                .delete_slack_workspace_authorization_fault => "DeleteSlackWorkspaceAuthorizationFault",
                .delete_teams_channel_configuration_exception => "DeleteTeamsChannelConfigurationException",
                .delete_teams_configured_team_exception => "DeleteTeamsConfiguredTeamException",
                .describe_chime_webhook_configurations_exception => "DescribeChimeWebhookConfigurationsException",
                .describe_slack_channel_configurations_exception => "DescribeSlackChannelConfigurationsException",
                .describe_slack_user_identities_exception => "DescribeSlackUserIdentitiesException",
                .describe_slack_workspaces_exception => "DescribeSlackWorkspacesException",
                .get_account_preferences_exception => "GetAccountPreferencesException",
                .get_teams_channel_configuration_exception => "GetTeamsChannelConfigurationException",
                .internal_service_error => "InternalServiceError",
                .invalid_parameter_exception => "InvalidParameterException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .list_microsoft_teams_configured_teams_exception => "ListMicrosoftTeamsConfiguredTeamsException",
                .list_microsoft_teams_user_identities_exception => "ListMicrosoftTeamsUserIdentitiesException",
                .list_teams_channel_configurations_exception => "ListTeamsChannelConfigurationsException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_tags_exception => "TooManyTagsException",
                .unauthorized_exception => "UnauthorizedException",
                .update_account_preferences_exception => "UpdateAccountPreferencesException",
                .update_chime_webhook_configuration_exception => "UpdateChimeWebhookConfigurationException",
                .update_slack_channel_configuration_exception => "UpdateSlackChannelConfigurationException",
                .update_teams_channel_configuration_exception => "UpdateTeamsChannelConfigurationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.message,
                .create_chime_webhook_configuration_exception => |e| e.message,
                .create_slack_channel_configuration_exception => |e| e.message,
                .create_teams_channel_configuration_exception => |e| e.message,
                .delete_chime_webhook_configuration_exception => |e| e.message,
                .delete_microsoft_teams_user_identity_exception => |e| e.message,
                .delete_slack_channel_configuration_exception => |e| e.message,
                .delete_slack_user_identity_exception => |e| e.message,
                .delete_slack_workspace_authorization_fault => |e| e.message,
                .delete_teams_channel_configuration_exception => |e| e.message,
                .delete_teams_configured_team_exception => |e| e.message,
                .describe_chime_webhook_configurations_exception => |e| e.message,
                .describe_slack_channel_configurations_exception => |e| e.message,
                .describe_slack_user_identities_exception => |e| e.message,
                .describe_slack_workspaces_exception => |e| e.message,
                .get_account_preferences_exception => |e| e.message,
                .get_teams_channel_configuration_exception => |e| e.message,
                .internal_service_error => |e| e.message,
                .invalid_parameter_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .list_microsoft_teams_configured_teams_exception => |e| e.message,
                .list_microsoft_teams_user_identities_exception => |e| e.message,
                .list_teams_channel_configurations_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unauthorized_exception => |e| e.message,
                .update_account_preferences_exception => |e| e.message,
                .update_chime_webhook_configuration_exception => |e| e.message,
                .update_slack_channel_configuration_exception => |e| e.message,
                .update_teams_channel_configuration_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .conflict_exception => 409,
                .create_chime_webhook_configuration_exception => 500,
                .create_slack_channel_configuration_exception => 500,
                .create_teams_channel_configuration_exception => 500,
                .delete_chime_webhook_configuration_exception => 500,
                .delete_microsoft_teams_user_identity_exception => 500,
                .delete_slack_channel_configuration_exception => 500,
                .delete_slack_user_identity_exception => 500,
                .delete_slack_workspace_authorization_fault => 500,
                .delete_teams_channel_configuration_exception => 500,
                .delete_teams_configured_team_exception => 500,
                .describe_chime_webhook_configurations_exception => 500,
                .describe_slack_channel_configurations_exception => 500,
                .describe_slack_user_identities_exception => 500,
                .describe_slack_workspaces_exception => 500,
                .get_account_preferences_exception => 500,
                .get_teams_channel_configuration_exception => 500,
                .internal_service_error => 500,
                .invalid_parameter_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 403,
                .list_microsoft_teams_configured_teams_exception => 500,
                .list_microsoft_teams_user_identities_exception => 500,
                .list_teams_channel_configurations_exception => 500,
                .resource_not_found_exception => 404,
                .service_unavailable_exception => 429,
                .too_many_tags_exception => 400,
                .unauthorized_exception => 403,
                .update_account_preferences_exception => 500,
                .update_chime_webhook_configuration_exception => 500,
                .update_slack_channel_configuration_exception => 500,
                .update_teams_channel_configuration_exception => 500,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .conflict_exception => |e| e.request_id,
                .create_chime_webhook_configuration_exception => |e| e.request_id,
                .create_slack_channel_configuration_exception => |e| e.request_id,
                .create_teams_channel_configuration_exception => |e| e.request_id,
                .delete_chime_webhook_configuration_exception => |e| e.request_id,
                .delete_microsoft_teams_user_identity_exception => |e| e.request_id,
                .delete_slack_channel_configuration_exception => |e| e.request_id,
                .delete_slack_user_identity_exception => |e| e.request_id,
                .delete_slack_workspace_authorization_fault => |e| e.request_id,
                .delete_teams_channel_configuration_exception => |e| e.request_id,
                .delete_teams_configured_team_exception => |e| e.request_id,
                .describe_chime_webhook_configurations_exception => |e| e.request_id,
                .describe_slack_channel_configurations_exception => |e| e.request_id,
                .describe_slack_user_identities_exception => |e| e.request_id,
                .describe_slack_workspaces_exception => |e| e.request_id,
                .get_account_preferences_exception => |e| e.request_id,
                .get_teams_channel_configuration_exception => |e| e.request_id,
                .internal_service_error => |e| e.request_id,
                .invalid_parameter_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .list_microsoft_teams_configured_teams_exception => |e| e.request_id,
                .list_microsoft_teams_user_identities_exception => |e| e.request_id,
                .list_teams_channel_configurations_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unauthorized_exception => |e| e.request_id,
                .update_account_preferences_exception => |e| e.request_id,
                .update_chime_webhook_configuration_exception => |e| e.request_id,
                .update_slack_channel_configuration_exception => |e| e.request_id,
                .update_teams_channel_configuration_exception => |e| e.request_id,
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

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateChimeWebhookConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateSlackChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CreateTeamsChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteChimeWebhookConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteMicrosoftTeamsUserIdentityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteSlackChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteSlackUserIdentityException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteSlackWorkspaceAuthorizationFault = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteTeamsChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeleteTeamsConfiguredTeamException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DescribeChimeWebhookConfigurationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DescribeSlackChannelConfigurationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DescribeSlackUserIdentitiesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DescribeSlackWorkspacesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GetAccountPreferencesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const GetTeamsChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServiceError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidParameterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ListMicrosoftTeamsConfiguredTeamsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ListMicrosoftTeamsUserIdentitiesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ListTeamsChannelConfigurationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnauthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UpdateAccountPreferencesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UpdateChimeWebhookConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UpdateSlackChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UpdateTeamsChannelConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
