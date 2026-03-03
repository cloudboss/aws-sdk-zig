const aws = @import("aws");
const std = @import("std");

const associate_browser_settings = @import("associate_browser_settings.zig");
const associate_data_protection_settings = @import("associate_data_protection_settings.zig");
const associate_ip_access_settings = @import("associate_ip_access_settings.zig");
const associate_network_settings = @import("associate_network_settings.zig");
const associate_session_logger = @import("associate_session_logger.zig");
const associate_trust_store = @import("associate_trust_store.zig");
const associate_user_access_logging_settings = @import("associate_user_access_logging_settings.zig");
const associate_user_settings = @import("associate_user_settings.zig");
const create_browser_settings = @import("create_browser_settings.zig");
const create_data_protection_settings = @import("create_data_protection_settings.zig");
const create_identity_provider = @import("create_identity_provider.zig");
const create_ip_access_settings = @import("create_ip_access_settings.zig");
const create_network_settings = @import("create_network_settings.zig");
const create_portal = @import("create_portal.zig");
const create_session_logger = @import("create_session_logger.zig");
const create_trust_store = @import("create_trust_store.zig");
const create_user_access_logging_settings = @import("create_user_access_logging_settings.zig");
const create_user_settings = @import("create_user_settings.zig");
const delete_browser_settings = @import("delete_browser_settings.zig");
const delete_data_protection_settings = @import("delete_data_protection_settings.zig");
const delete_identity_provider = @import("delete_identity_provider.zig");
const delete_ip_access_settings = @import("delete_ip_access_settings.zig");
const delete_network_settings = @import("delete_network_settings.zig");
const delete_portal = @import("delete_portal.zig");
const delete_session_logger = @import("delete_session_logger.zig");
const delete_trust_store = @import("delete_trust_store.zig");
const delete_user_access_logging_settings = @import("delete_user_access_logging_settings.zig");
const delete_user_settings = @import("delete_user_settings.zig");
const disassociate_browser_settings = @import("disassociate_browser_settings.zig");
const disassociate_data_protection_settings = @import("disassociate_data_protection_settings.zig");
const disassociate_ip_access_settings = @import("disassociate_ip_access_settings.zig");
const disassociate_network_settings = @import("disassociate_network_settings.zig");
const disassociate_session_logger = @import("disassociate_session_logger.zig");
const disassociate_trust_store = @import("disassociate_trust_store.zig");
const disassociate_user_access_logging_settings = @import("disassociate_user_access_logging_settings.zig");
const disassociate_user_settings = @import("disassociate_user_settings.zig");
const expire_session = @import("expire_session.zig");
const get_browser_settings = @import("get_browser_settings.zig");
const get_data_protection_settings = @import("get_data_protection_settings.zig");
const get_identity_provider = @import("get_identity_provider.zig");
const get_ip_access_settings = @import("get_ip_access_settings.zig");
const get_network_settings = @import("get_network_settings.zig");
const get_portal = @import("get_portal.zig");
const get_portal_service_provider_metadata = @import("get_portal_service_provider_metadata.zig");
const get_session = @import("get_session.zig");
const get_session_logger = @import("get_session_logger.zig");
const get_trust_store = @import("get_trust_store.zig");
const get_trust_store_certificate = @import("get_trust_store_certificate.zig");
const get_user_access_logging_settings = @import("get_user_access_logging_settings.zig");
const get_user_settings = @import("get_user_settings.zig");
const list_browser_settings = @import("list_browser_settings.zig");
const list_data_protection_settings = @import("list_data_protection_settings.zig");
const list_identity_providers = @import("list_identity_providers.zig");
const list_ip_access_settings = @import("list_ip_access_settings.zig");
const list_network_settings = @import("list_network_settings.zig");
const list_portals = @import("list_portals.zig");
const list_session_loggers = @import("list_session_loggers.zig");
const list_sessions = @import("list_sessions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_trust_store_certificates = @import("list_trust_store_certificates.zig");
const list_trust_stores = @import("list_trust_stores.zig");
const list_user_access_logging_settings = @import("list_user_access_logging_settings.zig");
const list_user_settings = @import("list_user_settings.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_browser_settings = @import("update_browser_settings.zig");
const update_data_protection_settings = @import("update_data_protection_settings.zig");
const update_identity_provider = @import("update_identity_provider.zig");
const update_ip_access_settings = @import("update_ip_access_settings.zig");
const update_network_settings = @import("update_network_settings.zig");
const update_portal = @import("update_portal.zig");
const update_session_logger = @import("update_session_logger.zig");
const update_trust_store = @import("update_trust_store.zig");
const update_user_access_logging_settings = @import("update_user_access_logging_settings.zig");
const update_user_settings = @import("update_user_settings.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WorkSpaces Web";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates a browser settings resource with a web portal.
    pub fn associateBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: associate_browser_settings.AssociateBrowserSettingsInput, options: associate_browser_settings.Options) !associate_browser_settings.AssociateBrowserSettingsOutput {
        return associate_browser_settings.execute(self, allocator, input, options);
    }

    /// Associates a data protection settings resource with a web portal.
    pub fn associateDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: associate_data_protection_settings.AssociateDataProtectionSettingsInput, options: associate_data_protection_settings.Options) !associate_data_protection_settings.AssociateDataProtectionSettingsOutput {
        return associate_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Associates an IP access settings resource with a web portal.
    pub fn associateIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: associate_ip_access_settings.AssociateIpAccessSettingsInput, options: associate_ip_access_settings.Options) !associate_ip_access_settings.AssociateIpAccessSettingsOutput {
        return associate_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Associates a network settings resource with a web portal.
    pub fn associateNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: associate_network_settings.AssociateNetworkSettingsInput, options: associate_network_settings.Options) !associate_network_settings.AssociateNetworkSettingsOutput {
        return associate_network_settings.execute(self, allocator, input, options);
    }

    /// Associates a session logger with a portal.
    pub fn associateSessionLogger(self: *Self, allocator: std.mem.Allocator, input: associate_session_logger.AssociateSessionLoggerInput, options: associate_session_logger.Options) !associate_session_logger.AssociateSessionLoggerOutput {
        return associate_session_logger.execute(self, allocator, input, options);
    }

    /// Associates a trust store with a web portal.
    pub fn associateTrustStore(self: *Self, allocator: std.mem.Allocator, input: associate_trust_store.AssociateTrustStoreInput, options: associate_trust_store.Options) !associate_trust_store.AssociateTrustStoreOutput {
        return associate_trust_store.execute(self, allocator, input, options);
    }

    /// Associates a user access logging settings resource with a web portal.
    pub fn associateUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: associate_user_access_logging_settings.AssociateUserAccessLoggingSettingsInput, options: associate_user_access_logging_settings.Options) !associate_user_access_logging_settings.AssociateUserAccessLoggingSettingsOutput {
        return associate_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Associates a user settings resource with a web portal.
    pub fn associateUserSettings(self: *Self, allocator: std.mem.Allocator, input: associate_user_settings.AssociateUserSettingsInput, options: associate_user_settings.Options) !associate_user_settings.AssociateUserSettingsOutput {
        return associate_user_settings.execute(self, allocator, input, options);
    }

    /// Creates a browser settings resource that can be associated with a web
    /// portal. Once associated with a web portal, browser settings control how the
    /// browser will behave once a user starts a streaming session for the web
    /// portal.
    pub fn createBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: create_browser_settings.CreateBrowserSettingsInput, options: create_browser_settings.Options) !create_browser_settings.CreateBrowserSettingsOutput {
        return create_browser_settings.execute(self, allocator, input, options);
    }

    /// Creates a data protection settings resource that can be associated with a
    /// web portal.
    pub fn createDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: create_data_protection_settings.CreateDataProtectionSettingsInput, options: create_data_protection_settings.Options) !create_data_protection_settings.CreateDataProtectionSettingsOutput {
        return create_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Creates an identity provider resource that is then associated with a web
    /// portal.
    pub fn createIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: create_identity_provider.CreateIdentityProviderInput, options: create_identity_provider.Options) !create_identity_provider.CreateIdentityProviderOutput {
        return create_identity_provider.execute(self, allocator, input, options);
    }

    /// Creates an IP access settings resource that can be associated with a web
    /// portal.
    pub fn createIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: create_ip_access_settings.CreateIpAccessSettingsInput, options: create_ip_access_settings.Options) !create_ip_access_settings.CreateIpAccessSettingsOutput {
        return create_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Creates a network settings resource that can be associated with a web
    /// portal. Once associated with a web portal, network settings define how
    /// streaming instances will connect with your specified VPC.
    pub fn createNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: create_network_settings.CreateNetworkSettingsInput, options: create_network_settings.Options) !create_network_settings.CreateNetworkSettingsOutput {
        return create_network_settings.execute(self, allocator, input, options);
    }

    /// Creates a web portal.
    pub fn createPortal(self: *Self, allocator: std.mem.Allocator, input: create_portal.CreatePortalInput, options: create_portal.Options) !create_portal.CreatePortalOutput {
        return create_portal.execute(self, allocator, input, options);
    }

    /// Creates a session logger.
    pub fn createSessionLogger(self: *Self, allocator: std.mem.Allocator, input: create_session_logger.CreateSessionLoggerInput, options: create_session_logger.Options) !create_session_logger.CreateSessionLoggerOutput {
        return create_session_logger.execute(self, allocator, input, options);
    }

    /// Creates a trust store that can be associated with a web portal. A trust
    /// store contains certificate authority (CA) certificates. Once associated with
    /// a web portal, the browser in a streaming session will recognize certificates
    /// that have been issued using any of the CAs in the trust store. If your
    /// organization has internal websites that use certificates issued by private
    /// CAs, you should add the private CA certificate to the trust store.
    pub fn createTrustStore(self: *Self, allocator: std.mem.Allocator, input: create_trust_store.CreateTrustStoreInput, options: create_trust_store.Options) !create_trust_store.CreateTrustStoreOutput {
        return create_trust_store.execute(self, allocator, input, options);
    }

    /// Creates a user access logging settings resource that can be associated with
    /// a web portal.
    pub fn createUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: create_user_access_logging_settings.CreateUserAccessLoggingSettingsInput, options: create_user_access_logging_settings.Options) !create_user_access_logging_settings.CreateUserAccessLoggingSettingsOutput {
        return create_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Creates a user settings resource that can be associated with a web portal.
    /// Once associated with a web portal, user settings control how users can
    /// transfer data between a streaming session and the their local devices.
    pub fn createUserSettings(self: *Self, allocator: std.mem.Allocator, input: create_user_settings.CreateUserSettingsInput, options: create_user_settings.Options) !create_user_settings.CreateUserSettingsOutput {
        return create_user_settings.execute(self, allocator, input, options);
    }

    /// Deletes browser settings.
    pub fn deleteBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: delete_browser_settings.DeleteBrowserSettingsInput, options: delete_browser_settings.Options) !delete_browser_settings.DeleteBrowserSettingsOutput {
        return delete_browser_settings.execute(self, allocator, input, options);
    }

    /// Deletes data protection settings.
    pub fn deleteDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: delete_data_protection_settings.DeleteDataProtectionSettingsInput, options: delete_data_protection_settings.Options) !delete_data_protection_settings.DeleteDataProtectionSettingsOutput {
        return delete_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Deletes the identity provider.
    pub fn deleteIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: delete_identity_provider.DeleteIdentityProviderInput, options: delete_identity_provider.Options) !delete_identity_provider.DeleteIdentityProviderOutput {
        return delete_identity_provider.execute(self, allocator, input, options);
    }

    /// Deletes IP access settings.
    pub fn deleteIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: delete_ip_access_settings.DeleteIpAccessSettingsInput, options: delete_ip_access_settings.Options) !delete_ip_access_settings.DeleteIpAccessSettingsOutput {
        return delete_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Deletes network settings.
    pub fn deleteNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: delete_network_settings.DeleteNetworkSettingsInput, options: delete_network_settings.Options) !delete_network_settings.DeleteNetworkSettingsOutput {
        return delete_network_settings.execute(self, allocator, input, options);
    }

    /// Deletes a web portal.
    pub fn deletePortal(self: *Self, allocator: std.mem.Allocator, input: delete_portal.DeletePortalInput, options: delete_portal.Options) !delete_portal.DeletePortalOutput {
        return delete_portal.execute(self, allocator, input, options);
    }

    /// Deletes a session logger resource.
    pub fn deleteSessionLogger(self: *Self, allocator: std.mem.Allocator, input: delete_session_logger.DeleteSessionLoggerInput, options: delete_session_logger.Options) !delete_session_logger.DeleteSessionLoggerOutput {
        return delete_session_logger.execute(self, allocator, input, options);
    }

    /// Deletes the trust store.
    pub fn deleteTrustStore(self: *Self, allocator: std.mem.Allocator, input: delete_trust_store.DeleteTrustStoreInput, options: delete_trust_store.Options) !delete_trust_store.DeleteTrustStoreOutput {
        return delete_trust_store.execute(self, allocator, input, options);
    }

    /// Deletes user access logging settings.
    pub fn deleteUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: delete_user_access_logging_settings.DeleteUserAccessLoggingSettingsInput, options: delete_user_access_logging_settings.Options) !delete_user_access_logging_settings.DeleteUserAccessLoggingSettingsOutput {
        return delete_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Deletes user settings.
    pub fn deleteUserSettings(self: *Self, allocator: std.mem.Allocator, input: delete_user_settings.DeleteUserSettingsInput, options: delete_user_settings.Options) !delete_user_settings.DeleteUserSettingsOutput {
        return delete_user_settings.execute(self, allocator, input, options);
    }

    /// Disassociates browser settings from a web portal.
    pub fn disassociateBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: disassociate_browser_settings.DisassociateBrowserSettingsInput, options: disassociate_browser_settings.Options) !disassociate_browser_settings.DisassociateBrowserSettingsOutput {
        return disassociate_browser_settings.execute(self, allocator, input, options);
    }

    /// Disassociates data protection settings from a web portal.
    pub fn disassociateDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: disassociate_data_protection_settings.DisassociateDataProtectionSettingsInput, options: disassociate_data_protection_settings.Options) !disassociate_data_protection_settings.DisassociateDataProtectionSettingsOutput {
        return disassociate_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Disassociates IP access settings from a web portal.
    pub fn disassociateIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: disassociate_ip_access_settings.DisassociateIpAccessSettingsInput, options: disassociate_ip_access_settings.Options) !disassociate_ip_access_settings.DisassociateIpAccessSettingsOutput {
        return disassociate_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Disassociates network settings from a web portal.
    pub fn disassociateNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: disassociate_network_settings.DisassociateNetworkSettingsInput, options: disassociate_network_settings.Options) !disassociate_network_settings.DisassociateNetworkSettingsOutput {
        return disassociate_network_settings.execute(self, allocator, input, options);
    }

    /// Disassociates a session logger from a portal.
    pub fn disassociateSessionLogger(self: *Self, allocator: std.mem.Allocator, input: disassociate_session_logger.DisassociateSessionLoggerInput, options: disassociate_session_logger.Options) !disassociate_session_logger.DisassociateSessionLoggerOutput {
        return disassociate_session_logger.execute(self, allocator, input, options);
    }

    /// Disassociates a trust store from a web portal.
    pub fn disassociateTrustStore(self: *Self, allocator: std.mem.Allocator, input: disassociate_trust_store.DisassociateTrustStoreInput, options: disassociate_trust_store.Options) !disassociate_trust_store.DisassociateTrustStoreOutput {
        return disassociate_trust_store.execute(self, allocator, input, options);
    }

    /// Disassociates user access logging settings from a web portal.
    pub fn disassociateUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: disassociate_user_access_logging_settings.DisassociateUserAccessLoggingSettingsInput, options: disassociate_user_access_logging_settings.Options) !disassociate_user_access_logging_settings.DisassociateUserAccessLoggingSettingsOutput {
        return disassociate_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Disassociates user settings from a web portal.
    pub fn disassociateUserSettings(self: *Self, allocator: std.mem.Allocator, input: disassociate_user_settings.DisassociateUserSettingsInput, options: disassociate_user_settings.Options) !disassociate_user_settings.DisassociateUserSettingsOutput {
        return disassociate_user_settings.execute(self, allocator, input, options);
    }

    /// Expires an active secure browser session.
    pub fn expireSession(self: *Self, allocator: std.mem.Allocator, input: expire_session.ExpireSessionInput, options: expire_session.Options) !expire_session.ExpireSessionOutput {
        return expire_session.execute(self, allocator, input, options);
    }

    /// Gets browser settings.
    pub fn getBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: get_browser_settings.GetBrowserSettingsInput, options: get_browser_settings.Options) !get_browser_settings.GetBrowserSettingsOutput {
        return get_browser_settings.execute(self, allocator, input, options);
    }

    /// Gets the data protection settings.
    pub fn getDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: get_data_protection_settings.GetDataProtectionSettingsInput, options: get_data_protection_settings.Options) !get_data_protection_settings.GetDataProtectionSettingsOutput {
        return get_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Gets the identity provider.
    pub fn getIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: get_identity_provider.GetIdentityProviderInput, options: get_identity_provider.Options) !get_identity_provider.GetIdentityProviderOutput {
        return get_identity_provider.execute(self, allocator, input, options);
    }

    /// Gets the IP access settings.
    pub fn getIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: get_ip_access_settings.GetIpAccessSettingsInput, options: get_ip_access_settings.Options) !get_ip_access_settings.GetIpAccessSettingsOutput {
        return get_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Gets the network settings.
    pub fn getNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: get_network_settings.GetNetworkSettingsInput, options: get_network_settings.Options) !get_network_settings.GetNetworkSettingsOutput {
        return get_network_settings.execute(self, allocator, input, options);
    }

    /// Gets the web portal.
    pub fn getPortal(self: *Self, allocator: std.mem.Allocator, input: get_portal.GetPortalInput, options: get_portal.Options) !get_portal.GetPortalOutput {
        return get_portal.execute(self, allocator, input, options);
    }

    /// Gets the service provider metadata.
    pub fn getPortalServiceProviderMetadata(self: *Self, allocator: std.mem.Allocator, input: get_portal_service_provider_metadata.GetPortalServiceProviderMetadataInput, options: get_portal_service_provider_metadata.Options) !get_portal_service_provider_metadata.GetPortalServiceProviderMetadataOutput {
        return get_portal_service_provider_metadata.execute(self, allocator, input, options);
    }

    /// Gets information for a secure browser session.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: get_session.Options) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Gets details about a specific session logger resource.
    pub fn getSessionLogger(self: *Self, allocator: std.mem.Allocator, input: get_session_logger.GetSessionLoggerInput, options: get_session_logger.Options) !get_session_logger.GetSessionLoggerOutput {
        return get_session_logger.execute(self, allocator, input, options);
    }

    /// Gets the trust store.
    pub fn getTrustStore(self: *Self, allocator: std.mem.Allocator, input: get_trust_store.GetTrustStoreInput, options: get_trust_store.Options) !get_trust_store.GetTrustStoreOutput {
        return get_trust_store.execute(self, allocator, input, options);
    }

    /// Gets the trust store certificate.
    pub fn getTrustStoreCertificate(self: *Self, allocator: std.mem.Allocator, input: get_trust_store_certificate.GetTrustStoreCertificateInput, options: get_trust_store_certificate.Options) !get_trust_store_certificate.GetTrustStoreCertificateOutput {
        return get_trust_store_certificate.execute(self, allocator, input, options);
    }

    /// Gets user access logging settings.
    pub fn getUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: get_user_access_logging_settings.GetUserAccessLoggingSettingsInput, options: get_user_access_logging_settings.Options) !get_user_access_logging_settings.GetUserAccessLoggingSettingsOutput {
        return get_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Gets user settings.
    pub fn getUserSettings(self: *Self, allocator: std.mem.Allocator, input: get_user_settings.GetUserSettingsInput, options: get_user_settings.Options) !get_user_settings.GetUserSettingsOutput {
        return get_user_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of browser settings.
    pub fn listBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: list_browser_settings.ListBrowserSettingsInput, options: list_browser_settings.Options) !list_browser_settings.ListBrowserSettingsOutput {
        return list_browser_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of data protection settings.
    pub fn listDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: list_data_protection_settings.ListDataProtectionSettingsInput, options: list_data_protection_settings.Options) !list_data_protection_settings.ListDataProtectionSettingsOutput {
        return list_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of identity providers for a specific web portal.
    pub fn listIdentityProviders(self: *Self, allocator: std.mem.Allocator, input: list_identity_providers.ListIdentityProvidersInput, options: list_identity_providers.Options) !list_identity_providers.ListIdentityProvidersOutput {
        return list_identity_providers.execute(self, allocator, input, options);
    }

    /// Retrieves a list of IP access settings.
    pub fn listIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: list_ip_access_settings.ListIpAccessSettingsInput, options: list_ip_access_settings.Options) !list_ip_access_settings.ListIpAccessSettingsOutput {
        return list_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of network settings.
    pub fn listNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: list_network_settings.ListNetworkSettingsInput, options: list_network_settings.Options) !list_network_settings.ListNetworkSettingsOutput {
        return list_network_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a list or web portals.
    pub fn listPortals(self: *Self, allocator: std.mem.Allocator, input: list_portals.ListPortalsInput, options: list_portals.Options) !list_portals.ListPortalsOutput {
        return list_portals.execute(self, allocator, input, options);
    }

    /// Lists all available session logger resources.
    pub fn listSessionLoggers(self: *Self, allocator: std.mem.Allocator, input: list_session_loggers.ListSessionLoggersInput, options: list_session_loggers.Options) !list_session_loggers.ListSessionLoggersOutput {
        return list_session_loggers.execute(self, allocator, input, options);
    }

    /// Lists information for multiple secure browser sessions from a specific
    /// portal.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: list_sessions.Options) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of trust store certificates.
    pub fn listTrustStoreCertificates(self: *Self, allocator: std.mem.Allocator, input: list_trust_store_certificates.ListTrustStoreCertificatesInput, options: list_trust_store_certificates.Options) !list_trust_store_certificates.ListTrustStoreCertificatesOutput {
        return list_trust_store_certificates.execute(self, allocator, input, options);
    }

    /// Retrieves a list of trust stores.
    pub fn listTrustStores(self: *Self, allocator: std.mem.Allocator, input: list_trust_stores.ListTrustStoresInput, options: list_trust_stores.Options) !list_trust_stores.ListTrustStoresOutput {
        return list_trust_stores.execute(self, allocator, input, options);
    }

    /// Retrieves a list of user access logging settings.
    pub fn listUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: list_user_access_logging_settings.ListUserAccessLoggingSettingsInput, options: list_user_access_logging_settings.Options) !list_user_access_logging_settings.ListUserAccessLoggingSettingsOutput {
        return list_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Retrieves a list of user settings.
    pub fn listUserSettings(self: *Self, allocator: std.mem.Allocator, input: list_user_settings.ListUserSettingsInput, options: list_user_settings.Options) !list_user_settings.ListUserSettingsOutput {
        return list_user_settings.execute(self, allocator, input, options);
    }

    /// Adds or overwrites one or more tags for the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates browser settings.
    pub fn updateBrowserSettings(self: *Self, allocator: std.mem.Allocator, input: update_browser_settings.UpdateBrowserSettingsInput, options: update_browser_settings.Options) !update_browser_settings.UpdateBrowserSettingsOutput {
        return update_browser_settings.execute(self, allocator, input, options);
    }

    /// Updates data protection settings.
    pub fn updateDataProtectionSettings(self: *Self, allocator: std.mem.Allocator, input: update_data_protection_settings.UpdateDataProtectionSettingsInput, options: update_data_protection_settings.Options) !update_data_protection_settings.UpdateDataProtectionSettingsOutput {
        return update_data_protection_settings.execute(self, allocator, input, options);
    }

    /// Updates the identity provider.
    pub fn updateIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: update_identity_provider.UpdateIdentityProviderInput, options: update_identity_provider.Options) !update_identity_provider.UpdateIdentityProviderOutput {
        return update_identity_provider.execute(self, allocator, input, options);
    }

    /// Updates IP access settings.
    pub fn updateIpAccessSettings(self: *Self, allocator: std.mem.Allocator, input: update_ip_access_settings.UpdateIpAccessSettingsInput, options: update_ip_access_settings.Options) !update_ip_access_settings.UpdateIpAccessSettingsOutput {
        return update_ip_access_settings.execute(self, allocator, input, options);
    }

    /// Updates network settings.
    pub fn updateNetworkSettings(self: *Self, allocator: std.mem.Allocator, input: update_network_settings.UpdateNetworkSettingsInput, options: update_network_settings.Options) !update_network_settings.UpdateNetworkSettingsOutput {
        return update_network_settings.execute(self, allocator, input, options);
    }

    /// Updates a web portal.
    pub fn updatePortal(self: *Self, allocator: std.mem.Allocator, input: update_portal.UpdatePortalInput, options: update_portal.Options) !update_portal.UpdatePortalOutput {
        return update_portal.execute(self, allocator, input, options);
    }

    /// Updates the details of a session logger.
    pub fn updateSessionLogger(self: *Self, allocator: std.mem.Allocator, input: update_session_logger.UpdateSessionLoggerInput, options: update_session_logger.Options) !update_session_logger.UpdateSessionLoggerOutput {
        return update_session_logger.execute(self, allocator, input, options);
    }

    /// Updates the trust store.
    pub fn updateTrustStore(self: *Self, allocator: std.mem.Allocator, input: update_trust_store.UpdateTrustStoreInput, options: update_trust_store.Options) !update_trust_store.UpdateTrustStoreOutput {
        return update_trust_store.execute(self, allocator, input, options);
    }

    /// Updates the user access logging settings.
    pub fn updateUserAccessLoggingSettings(self: *Self, allocator: std.mem.Allocator, input: update_user_access_logging_settings.UpdateUserAccessLoggingSettingsInput, options: update_user_access_logging_settings.Options) !update_user_access_logging_settings.UpdateUserAccessLoggingSettingsOutput {
        return update_user_access_logging_settings.execute(self, allocator, input, options);
    }

    /// Updates the user settings.
    pub fn updateUserSettings(self: *Self, allocator: std.mem.Allocator, input: update_user_settings.UpdateUserSettingsInput, options: update_user_settings.Options) !update_user_settings.UpdateUserSettingsOutput {
        return update_user_settings.execute(self, allocator, input, options);
    }

    pub fn listBrowserSettingsPaginator(self: *Self, params: list_browser_settings.ListBrowserSettingsInput) paginator.ListBrowserSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataProtectionSettingsPaginator(self: *Self, params: list_data_protection_settings.ListDataProtectionSettingsInput) paginator.ListDataProtectionSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIdentityProvidersPaginator(self: *Self, params: list_identity_providers.ListIdentityProvidersInput) paginator.ListIdentityProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listIpAccessSettingsPaginator(self: *Self, params: list_ip_access_settings.ListIpAccessSettingsInput) paginator.ListIpAccessSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNetworkSettingsPaginator(self: *Self, params: list_network_settings.ListNetworkSettingsInput) paginator.ListNetworkSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPortalsPaginator(self: *Self, params: list_portals.ListPortalsInput) paginator.ListPortalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionLoggersPaginator(self: *Self, params: list_session_loggers.ListSessionLoggersInput) paginator.ListSessionLoggersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrustStoreCertificatesPaginator(self: *Self, params: list_trust_store_certificates.ListTrustStoreCertificatesInput) paginator.ListTrustStoreCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrustStoresPaginator(self: *Self, params: list_trust_stores.ListTrustStoresInput) paginator.ListTrustStoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserAccessLoggingSettingsPaginator(self: *Self, params: list_user_access_logging_settings.ListUserAccessLoggingSettingsInput) paginator.ListUserAccessLoggingSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUserSettingsPaginator(self: *Self, params: list_user_settings.ListUserSettingsInput) paginator.ListUserSettingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
