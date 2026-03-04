const aws = @import("aws");
const std = @import("std");

const batch_get_invoice_profile = @import("batch_get_invoice_profile.zig");
const create_invoice_unit = @import("create_invoice_unit.zig");
const create_procurement_portal_preference = @import("create_procurement_portal_preference.zig");
const delete_invoice_unit = @import("delete_invoice_unit.zig");
const delete_procurement_portal_preference = @import("delete_procurement_portal_preference.zig");
const get_invoice_pdf = @import("get_invoice_pdf.zig");
const get_invoice_unit = @import("get_invoice_unit.zig");
const get_procurement_portal_preference = @import("get_procurement_portal_preference.zig");
const list_invoice_summaries = @import("list_invoice_summaries.zig");
const list_invoice_units = @import("list_invoice_units.zig");
const list_procurement_portal_preferences = @import("list_procurement_portal_preferences.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_procurement_portal_preference = @import("put_procurement_portal_preference.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_invoice_unit = @import("update_invoice_unit.zig");
const update_procurement_portal_preference_status = @import("update_procurement_portal_preference_status.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Invoicing";

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

    /// This gets the invoice profile associated with a set of accounts. The
    /// accounts must be linked accounts under the requester management account
    /// organization.
    pub fn batchGetInvoiceProfile(self: *Self, allocator: std.mem.Allocator, input: batch_get_invoice_profile.BatchGetInvoiceProfileInput, options: CallOptions) !batch_get_invoice_profile.BatchGetInvoiceProfileOutput {
        return batch_get_invoice_profile.execute(self, allocator, input, options);
    }

    /// This creates a new invoice unit with the provided definition.
    pub fn createInvoiceUnit(self: *Self, allocator: std.mem.Allocator, input: create_invoice_unit.CreateInvoiceUnitInput, options: CallOptions) !create_invoice_unit.CreateInvoiceUnitOutput {
        return create_invoice_unit.execute(self, allocator, input, options);
    }

    /// Creates a procurement portal preference configuration for e-invoice delivery
    /// and purchase order retrieval. This preference defines how invoices are
    /// delivered to a procurement portal and how purchase orders are retrieved.
    pub fn createProcurementPortalPreference(self: *Self, allocator: std.mem.Allocator, input: create_procurement_portal_preference.CreateProcurementPortalPreferenceInput, options: CallOptions) !create_procurement_portal_preference.CreateProcurementPortalPreferenceOutput {
        return create_procurement_portal_preference.execute(self, allocator, input, options);
    }

    /// This deletes an invoice unit with the provided invoice unit ARN.
    pub fn deleteInvoiceUnit(self: *Self, allocator: std.mem.Allocator, input: delete_invoice_unit.DeleteInvoiceUnitInput, options: CallOptions) !delete_invoice_unit.DeleteInvoiceUnitOutput {
        return delete_invoice_unit.execute(self, allocator, input, options);
    }

    /// Deletes an existing procurement portal preference. This action cannot be
    /// undone. Active e-invoice delivery and PO retrieval configurations will be
    /// terminated.
    pub fn deleteProcurementPortalPreference(self: *Self, allocator: std.mem.Allocator, input: delete_procurement_portal_preference.DeleteProcurementPortalPreferenceInput, options: CallOptions) !delete_procurement_portal_preference.DeleteProcurementPortalPreferenceOutput {
        return delete_procurement_portal_preference.execute(self, allocator, input, options);
    }

    /// Returns a URL to download the invoice document and supplemental documents
    /// associated with an invoice. The URLs are pre-signed and have expiration
    /// time. For special cases like Brazil, where Amazon Web Services generated
    /// invoice identifiers and government provided identifiers do not match, use
    /// the Amazon Web Services generated invoice identifier when making API
    /// requests. To grant IAM permission to use this operation, the caller needs
    /// the `invoicing:GetInvoicePDF` policy action.
    pub fn getInvoicePdf(self: *Self, allocator: std.mem.Allocator, input: get_invoice_pdf.GetInvoicePDFInput, options: CallOptions) !get_invoice_pdf.GetInvoicePDFOutput {
        return get_invoice_pdf.execute(self, allocator, input, options);
    }

    /// This retrieves the invoice unit definition.
    pub fn getInvoiceUnit(self: *Self, allocator: std.mem.Allocator, input: get_invoice_unit.GetInvoiceUnitInput, options: CallOptions) !get_invoice_unit.GetInvoiceUnitOutput {
        return get_invoice_unit.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a specific procurement portal preference
    /// configuration.
    pub fn getProcurementPortalPreference(self: *Self, allocator: std.mem.Allocator, input: get_procurement_portal_preference.GetProcurementPortalPreferenceInput, options: CallOptions) !get_procurement_portal_preference.GetProcurementPortalPreferenceOutput {
        return get_procurement_portal_preference.execute(self, allocator, input, options);
    }

    /// Retrieves your invoice details programmatically, without line item details.
    pub fn listInvoiceSummaries(self: *Self, allocator: std.mem.Allocator, input: list_invoice_summaries.ListInvoiceSummariesInput, options: CallOptions) !list_invoice_summaries.ListInvoiceSummariesOutput {
        return list_invoice_summaries.execute(self, allocator, input, options);
    }

    /// This fetches a list of all invoice unit definitions for a given account, as
    /// of the provided `AsOf` date.
    pub fn listInvoiceUnits(self: *Self, allocator: std.mem.Allocator, input: list_invoice_units.ListInvoiceUnitsInput, options: CallOptions) !list_invoice_units.ListInvoiceUnitsOutput {
        return list_invoice_units.execute(self, allocator, input, options);
    }

    /// Retrieves a list of procurement portal preferences associated with the
    /// Amazon Web Services account.
    pub fn listProcurementPortalPreferences(self: *Self, allocator: std.mem.Allocator, input: list_procurement_portal_preferences.ListProcurementPortalPreferencesInput, options: CallOptions) !list_procurement_portal_preferences.ListProcurementPortalPreferencesOutput {
        return list_procurement_portal_preferences.execute(self, allocator, input, options);
    }

    /// Lists the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing procurement portal preference configuration. This
    /// operation can modify settings for e-invoice delivery and purchase order
    /// retrieval.
    pub fn putProcurementPortalPreference(self: *Self, allocator: std.mem.Allocator, input: put_procurement_portal_preference.PutProcurementPortalPreferenceInput, options: CallOptions) !put_procurement_portal_preference.PutProcurementPortalPreferenceOutput {
        return put_procurement_portal_preference.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// You can update the invoice unit configuration at any time, and Amazon Web
    /// Services will use the latest configuration at the end of the month.
    pub fn updateInvoiceUnit(self: *Self, allocator: std.mem.Allocator, input: update_invoice_unit.UpdateInvoiceUnitInput, options: CallOptions) !update_invoice_unit.UpdateInvoiceUnitOutput {
        return update_invoice_unit.execute(self, allocator, input, options);
    }

    /// Updates the status of a procurement portal preference, including the
    /// activation state of e-invoice delivery and purchase order retrieval
    /// features.
    pub fn updateProcurementPortalPreferenceStatus(self: *Self, allocator: std.mem.Allocator, input: update_procurement_portal_preference_status.UpdateProcurementPortalPreferenceStatusInput, options: CallOptions) !update_procurement_portal_preference_status.UpdateProcurementPortalPreferenceStatusOutput {
        return update_procurement_portal_preference_status.execute(self, allocator, input, options);
    }

    pub fn listInvoiceSummariesPaginator(self: *Self, params: list_invoice_summaries.ListInvoiceSummariesInput) paginator.ListInvoiceSummariesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInvoiceUnitsPaginator(self: *Self, params: list_invoice_units.ListInvoiceUnitsInput) paginator.ListInvoiceUnitsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listProcurementPortalPreferencesPaginator(self: *Self, params: list_procurement_portal_preferences.ListProcurementPortalPreferencesInput) paginator.ListProcurementPortalPreferencesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
