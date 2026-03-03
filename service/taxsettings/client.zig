const aws = @import("aws");
const std = @import("std");

const batch_delete_tax_registration = @import("batch_delete_tax_registration.zig");
const batch_get_tax_exemptions = @import("batch_get_tax_exemptions.zig");
const batch_put_tax_registration = @import("batch_put_tax_registration.zig");
const delete_supplemental_tax_registration = @import("delete_supplemental_tax_registration.zig");
const delete_tax_registration = @import("delete_tax_registration.zig");
const get_tax_exemption_types = @import("get_tax_exemption_types.zig");
const get_tax_inheritance = @import("get_tax_inheritance.zig");
const get_tax_registration = @import("get_tax_registration.zig");
const get_tax_registration_document = @import("get_tax_registration_document.zig");
const list_supplemental_tax_registrations = @import("list_supplemental_tax_registrations.zig");
const list_tax_exemptions = @import("list_tax_exemptions.zig");
const list_tax_registrations = @import("list_tax_registrations.zig");
const put_supplemental_tax_registration = @import("put_supplemental_tax_registration.zig");
const put_tax_exemption = @import("put_tax_exemption.zig");
const put_tax_inheritance = @import("put_tax_inheritance.zig");
const put_tax_registration = @import("put_tax_registration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "TaxSettings";

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

    /// Deletes tax registration for multiple accounts in batch. This can be used to
    /// delete tax
    /// registrations for up to five accounts in one batch.
    ///
    /// This API operation can't be used to delete your tax registration in Brazil.
    /// Use the [Payment
    /// preferences](https://console.aws.amazon.com/billing/home#/paymentpreferences/paymentmethods) page in the Billing and Cost Management console instead.
    pub fn batchDeleteTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: batch_delete_tax_registration.BatchDeleteTaxRegistrationInput, options: CallOptions) !batch_delete_tax_registration.BatchDeleteTaxRegistrationOutput {
        return batch_delete_tax_registration.execute(self, allocator, input, options);
    }

    /// Get the active tax exemptions for a given list of accounts. The IAM action
    /// is `tax:GetExemptions`.
    pub fn batchGetTaxExemptions(self: *Self, allocator: std.mem.Allocator, input: batch_get_tax_exemptions.BatchGetTaxExemptionsInput, options: CallOptions) !batch_get_tax_exemptions.BatchGetTaxExemptionsOutput {
        return batch_get_tax_exemptions.execute(self, allocator, input, options);
    }

    /// Adds or updates tax registration for multiple accounts in batch. This can be
    /// used to add
    /// or update tax registrations for up to five accounts in one batch. You can't
    /// set a TRN if there's a pending TRN. You'll need to delete the pending TRN
    /// first.
    ///
    /// To call this API operation for specific countries, see the following
    /// country-specific
    /// requirements.
    ///
    /// **Bangladesh**
    ///
    /// * You must specify the tax registration certificate document in the
    /// `taxRegistrationDocuments` field of the `VerificationDetails`
    /// object.
    ///
    /// **Brazil**
    ///
    /// * You must complete the tax registration process in the [Payment
    ///   preferences](https://console.aws.amazon.com/billing/home#/paymentpreferences/paymentmethods) page in the Billing and Cost Management console. After your TRN and billing address are verified, you can call this API operation.
    ///
    /// * For Amazon Web Services accounts created through Organizations, you can
    ///   call this API operation when you don't have a billing address.
    ///
    /// **Georgia**
    ///
    /// * The valid `personType` values are `Physical Person` and `Business`.
    ///
    /// **Indonesia**
    ///
    /// * `PutTaxRegistration`: The use of this operation to submit tax information
    ///   is subject to the [Amazon Web Services service
    ///   terms](http://aws.amazon.com/service-terms/). By submitting, you’re
    ///   providing consent for Amazon Web Services to validate NIK, NPWP, and NITKU
    ///   data, provided by you with the Directorate General of Taxes of Indonesia
    ///   in accordance with the Minister of Finance Regulation (PMK) Number
    ///   112/PMK.03/2022.
    ///
    /// * `BatchPutTaxRegistration`: The use of this operation to submit tax
    ///   information is subject to the [Amazon Web Services service
    ///   terms](http://aws.amazon.com/service-terms/). By submitting, you’re
    ///   providing consent for Amazon Web Services to validate NIK, NPWP, and NITKU
    ///   data, provided by you with the Directorate General of Taxes of Indonesia
    ///   in accordance with the Minister of Finance Regulation (PMK) Number
    ///   112/PMK.03/2022, through our third-party partner PT Achilles Advanced
    ///   Management (OnlinePajak).
    ///
    /// * You must specify the `taxRegistrationNumberType` in the
    ///   `indonesiaAdditionalInfo` field of the `additionalTaxInformation` object.
    ///
    /// * If you specify `decisionNumber`, you must specify the
    ///   `ppnExceptionDesignationCode` in the `indonesiaAdditionalInfo` field of
    ///   the `additionalTaxInformation` object. If the `taxRegistrationNumberType`
    ///   is set to NPWP or NITKU, valid values for `ppnExceptionDesignationCode`
    ///   are either `01`, `02`, `03`, `07`, or `08`.
    ///
    /// For other `taxRegistrationNumberType` values, `ppnExceptionDesignationCode`
    /// must be either `01`, `07`, or `08`.
    ///
    /// * If `ppnExceptionDesignationCode` is `07`, you must specify the
    ///   `decisionNumber` in the `indonesiaAdditionalInfo` field of the
    ///   `additionalTaxInformation` object.
    ///
    /// **Kenya**
    ///
    /// * You must specify the `personType` in the `kenyaAdditionalInfo`
    /// field of the `additionalTaxInformation` object.
    ///
    /// * If the `personType` is `Physical Person`, you must specify the
    /// tax registration certificate document in the `taxRegistrationDocuments`
    /// field
    /// of the `VerificationDetails` object.
    ///
    /// **Malaysia**
    ///
    /// * The sector valid values are `Business` and `Individual`.
    ///
    /// * `RegistrationType` valid values are `NRIC` for individual, and TIN and
    ///   sales and service tax (SST) for Business.
    ///
    /// * For individual, you can specify the `taxInformationNumber` in
    ///   `MalaysiaAdditionalInfo` with NRIC type, and a valid `MyKad` or NRIC
    ///   number.
    ///
    /// * For business, you must specify a `businessRegistrationNumber` in
    ///   `MalaysiaAdditionalInfo` with a TIN type and tax identification number.
    ///
    /// * For business resellers, you must specify a `businessRegistrationNumber`
    ///   and `taxInformationNumber` in `MalaysiaAdditionalInfo` with a sales and
    ///   service tax (SST) type and a valid SST number.
    ///
    /// * For business resellers with service codes, you must specify
    ///   `businessRegistrationNumber`, `taxInformationNumber`, and distinct
    ///   `serviceTaxCodes` in `MalaysiaAdditionalInfo` with a SST type and valid
    ///   sales and service tax (SST) number. By using this API operation, Amazon
    ///   Web Services registers your self-declaration that you’re an authorized
    ///   business reseller registered with the Royal Malaysia Customs Department
    ///   (RMCD), and have a valid SST number.
    ///
    /// * Amazon Web Services reserves the right to seek additional information
    ///   and/or take other actions to
    /// support your self-declaration as appropriate.
    ///
    /// * Amazon Web Services is currently registered under the following service
    ///   tax codes. You must include
    /// at least one of the service tax codes in the service tax code strings to
    /// declare yourself
    /// as an authorized registered business reseller.
    ///
    /// Taxable service and service tax codes:
    ///
    /// Consultancy - 9907061674
    ///
    /// Training or coaching service - 9907071685
    ///
    /// IT service - 9907101676
    ///
    /// Digital services and electronic medium - 9907121690
    ///
    /// **Nepal**
    ///
    /// * The sector valid values are `Business` and `Individual`.
    ///
    /// **Saudi Arabia**
    ///
    /// * For `address`, you must specify `addressLine3`.
    ///
    /// **South Korea**
    ///
    /// * You must specify the `certifiedEmailId` and `legalName` in the
    /// `TaxRegistrationEntry` object. Use Korean characters for
    /// `legalName`.
    ///
    /// * You must specify the `businessRepresentativeName`,
    /// `itemOfBusiness`, and `lineOfBusiness` in the
    /// `southKoreaAdditionalInfo` field of the `additionalTaxInformation`
    /// object. Use Korean characters for these fields.
    ///
    /// * You must specify the tax registration certificate document in the
    /// `taxRegistrationDocuments` field of the `VerificationDetails`
    /// object.
    ///
    /// * For the `address` object, use Korean characters for `addressLine1`,
    ///   `addressLine2`
    /// `city`, `postalCode`, and `stateOrRegion`.
    ///
    /// **Spain**
    ///
    /// * You must specify the `registrationType` in the
    /// `spainAdditionalInfo` field of the `additionalTaxInformation`
    /// object.
    ///
    /// * If the `registrationType` is `Local`, you must specify the tax
    /// registration certificate document in the `taxRegistrationDocuments` field of
    /// the `VerificationDetails` object.
    ///
    /// **Turkey**
    ///
    /// * You must specify the `sector` in the `taxRegistrationEntry` object.
    ///
    /// * If your `sector` is `Business`, `Individual`, or
    /// `Government`:
    ///
    /// * Specify the `taxOffice`. If your
    /// `sector` is `Individual`, don't enter this value.
    ///
    /// * (Optional) Specify the `kepEmailId`. If your
    /// `sector` is `Individual`, don't enter this value.
    ///
    /// * **Note:** In the **Tax Settings** page of the Billing console,
    ///   `Government` appears as **Public institutions**
    ///
    /// * If your `sector` is `Business` and you're subject to KDV tax,
    /// you must specify your industry in the `industries` field.
    ///
    /// * For `address`, you must specify `districtOrCounty`.
    ///
    /// **Ukraine**
    ///
    /// * The sector valid values are `Business` and `Individual`.
    pub fn batchPutTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: batch_put_tax_registration.BatchPutTaxRegistrationInput, options: CallOptions) !batch_put_tax_registration.BatchPutTaxRegistrationOutput {
        return batch_put_tax_registration.execute(self, allocator, input, options);
    }

    /// Deletes a supplemental tax registration for a single account.
    pub fn deleteSupplementalTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: delete_supplemental_tax_registration.DeleteSupplementalTaxRegistrationInput, options: CallOptions) !delete_supplemental_tax_registration.DeleteSupplementalTaxRegistrationOutput {
        return delete_supplemental_tax_registration.execute(self, allocator, input, options);
    }

    /// Deletes tax registration for a single account.
    ///
    /// This API operation can't be used to delete your tax registration in Brazil.
    /// Use the [Payment
    /// preferences](https://console.aws.amazon.com/billing/home#/paymentpreferences/paymentmethods) page in the Billing and Cost Management console instead.
    pub fn deleteTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: delete_tax_registration.DeleteTaxRegistrationInput, options: CallOptions) !delete_tax_registration.DeleteTaxRegistrationOutput {
        return delete_tax_registration.execute(self, allocator, input, options);
    }

    /// Get supported tax exemption types. The IAM action is `tax:GetExemptions`.
    pub fn getTaxExemptionTypes(self: *Self, allocator: std.mem.Allocator, input: get_tax_exemption_types.GetTaxExemptionTypesInput, options: CallOptions) !get_tax_exemption_types.GetTaxExemptionTypesOutput {
        return get_tax_exemption_types.execute(self, allocator, input, options);
    }

    /// The get account tax inheritance status.
    pub fn getTaxInheritance(self: *Self, allocator: std.mem.Allocator, input: get_tax_inheritance.GetTaxInheritanceInput, options: CallOptions) !get_tax_inheritance.GetTaxInheritanceOutput {
        return get_tax_inheritance.execute(self, allocator, input, options);
    }

    /// Retrieves tax registration for a single account.
    pub fn getTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: get_tax_registration.GetTaxRegistrationInput, options: CallOptions) !get_tax_registration.GetTaxRegistrationOutput {
        return get_tax_registration.execute(self, allocator, input, options);
    }

    /// Downloads your tax documents to the Amazon S3 bucket that you specify in
    /// your
    /// request.
    pub fn getTaxRegistrationDocument(self: *Self, allocator: std.mem.Allocator, input: get_tax_registration_document.GetTaxRegistrationDocumentInput, options: CallOptions) !get_tax_registration_document.GetTaxRegistrationDocumentOutput {
        return get_tax_registration_document.execute(self, allocator, input, options);
    }

    /// Retrieves supplemental tax registrations for a single account.
    pub fn listSupplementalTaxRegistrations(self: *Self, allocator: std.mem.Allocator, input: list_supplemental_tax_registrations.ListSupplementalTaxRegistrationsInput, options: CallOptions) !list_supplemental_tax_registrations.ListSupplementalTaxRegistrationsOutput {
        return list_supplemental_tax_registrations.execute(self, allocator, input, options);
    }

    /// Retrieves the tax exemption of accounts listed in a consolidated billing
    /// family. The IAM action is `tax:GetExemptions`.
    pub fn listTaxExemptions(self: *Self, allocator: std.mem.Allocator, input: list_tax_exemptions.ListTaxExemptionsInput, options: CallOptions) !list_tax_exemptions.ListTaxExemptionsOutput {
        return list_tax_exemptions.execute(self, allocator, input, options);
    }

    /// Retrieves the tax registration of accounts listed in a consolidated billing
    /// family. This
    /// can be used to retrieve up to 100 accounts' tax registrations in one call
    /// (default 50).
    pub fn listTaxRegistrations(self: *Self, allocator: std.mem.Allocator, input: list_tax_registrations.ListTaxRegistrationsInput, options: CallOptions) !list_tax_registrations.ListTaxRegistrationsOutput {
        return list_tax_registrations.execute(self, allocator, input, options);
    }

    /// Stores supplemental tax registration for a single account.
    pub fn putSupplementalTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: put_supplemental_tax_registration.PutSupplementalTaxRegistrationInput, options: CallOptions) !put_supplemental_tax_registration.PutSupplementalTaxRegistrationOutput {
        return put_supplemental_tax_registration.execute(self, allocator, input, options);
    }

    /// Adds the tax exemption for a single account or all accounts listed in a
    /// consolidated billing family. The IAM action is `tax:UpdateExemptions`.
    pub fn putTaxExemption(self: *Self, allocator: std.mem.Allocator, input: put_tax_exemption.PutTaxExemptionInput, options: CallOptions) !put_tax_exemption.PutTaxExemptionOutput {
        return put_tax_exemption.execute(self, allocator, input, options);
    }

    /// The updated tax inheritance status.
    pub fn putTaxInheritance(self: *Self, allocator: std.mem.Allocator, input: put_tax_inheritance.PutTaxInheritanceInput, options: CallOptions) !put_tax_inheritance.PutTaxInheritanceOutput {
        return put_tax_inheritance.execute(self, allocator, input, options);
    }

    /// Adds or updates tax registration for a single account. You can't set a TRN
    /// if there's a pending TRN. You'll need to delete the pending TRN first.
    ///
    /// To call this API operation for specific countries, see the following
    /// country-specific
    /// requirements.
    ///
    /// **Bangladesh**
    ///
    /// * You must specify the tax registration certificate document in the
    /// `taxRegistrationDocuments` field of the `VerificationDetails`
    /// object.
    ///
    /// **Brazil**
    ///
    /// * You must complete the tax registration process in the [Payment
    ///   preferences](https://console.aws.amazon.com/billing/home#/paymentpreferences/paymentmethods) page in the Billing and Cost Management console. After your TRN and billing address are verified, you can call this API operation.
    ///
    /// * For Amazon Web Services accounts created through Organizations, you can
    ///   call this API operation when you don't have a billing address.
    ///
    /// **Georgia**
    ///
    /// * The valid `personType` values are `Physical Person` and `Business`.
    ///
    /// **Indonesia**
    ///
    /// * `PutTaxRegistration`: The use of this operation to submit tax information
    ///   is subject to the [Amazon Web Services service
    ///   terms](http://aws.amazon.com/service-terms/). By submitting, you’re
    ///   providing consent for Amazon Web Services to validate NIK, NPWP, and NITKU
    ///   data, provided by you with the Directorate General of Taxes of Indonesia
    ///   in accordance with the Minister of Finance Regulation (PMK) Number
    ///   112/PMK.03/2022.
    ///
    /// * `BatchPutTaxRegistration`: The use of this operation to submit tax
    ///   information is subject to the [Amazon Web Services service
    ///   terms](http://aws.amazon.com/service-terms/). By submitting, you’re
    ///   providing consent for Amazon Web Services to validate NIK, NPWP, and NITKU
    ///   data, provided by you with the Directorate General of Taxes of Indonesia
    ///   in accordance with the Minister of Finance Regulation (PMK) Number
    ///   112/PMK.03/2022, through our third-party partner PT Achilles Advanced
    ///   Management (OnlinePajak).
    ///
    /// * You must specify the `taxRegistrationNumberType` in the
    ///   `indonesiaAdditionalInfo` field of the `additionalTaxInformation` object.
    ///
    /// * If you specify `decisionNumber`, you must specify the
    ///   `ppnExceptionDesignationCode` in the `indonesiaAdditionalInfo` field of
    ///   the `additionalTaxInformation` object. If the `taxRegistrationNumberType`
    ///   is set to NPWP or NITKU, valid values for `ppnExceptionDesignationCode`
    ///   are either `01`, `02`, `03`, `07`, or `08`.
    ///
    /// For other `taxRegistrationNumberType` values, `ppnExceptionDesignationCode`
    /// must be either `01`, `07`, or `08`.
    ///
    /// * If `ppnExceptionDesignationCode` is `07`, you must specify the
    ///   `decisionNumber` in the `indonesiaAdditionalInfo` field of the
    ///   `additionalTaxInformation` object.
    ///
    /// **Kenya**
    ///
    /// * You must specify the `personType` in the `kenyaAdditionalInfo`
    /// field of the `additionalTaxInformation` object.
    ///
    /// * If the `personType` is `Physical Person`, you must specify the
    /// tax registration certificate document in the `taxRegistrationDocuments`
    /// field
    /// of the `VerificationDetails` object.
    ///
    /// **Malaysia**
    ///
    /// * The sector valid values are `Business` and `Individual`.
    ///
    /// * `RegistrationType` valid values are `NRIC` for individual, and TIN and
    ///   sales and service tax (SST) for Business.
    ///
    /// * For individual, you can specify the `taxInformationNumber` in
    ///   `MalaysiaAdditionalInfo` with NRIC type, and a valid `MyKad` or NRIC
    ///   number.
    ///
    /// * For business, you must specify a `businessRegistrationNumber` in
    ///   `MalaysiaAdditionalInfo` with a TIN type and tax identification number.
    ///
    /// * For business resellers, you must specify a `businessRegistrationNumber`
    ///   and `taxInformationNumber` in `MalaysiaAdditionalInfo` with a sales and
    ///   service tax (SST) type and a valid SST number.
    ///
    /// * For business resellers with service codes, you must specify
    ///   `businessRegistrationNumber`, `taxInformationNumber`, and distinct
    ///   `serviceTaxCodes` in `MalaysiaAdditionalInfo` with a SST type and valid
    ///   sales and service tax (SST) number. By using this API operation, Amazon
    ///   Web Services registers your self-declaration that you’re an authorized
    ///   business reseller registered with the Royal Malaysia Customs Department
    ///   (RMCD), and have a valid SST number.
    ///
    /// * Amazon Web Services reserves the right to seek additional information
    ///   and/or take other actions to
    /// support your self-declaration as appropriate.
    ///
    /// * Amazon Web Services is currently registered under the following service
    ///   tax codes. You must include
    /// at least one of the service tax codes in the service tax code strings to
    /// declare yourself
    /// as an authorized registered business reseller.
    ///
    /// Taxable service and service tax codes:
    ///
    /// Consultancy - 9907061674
    ///
    /// Training or coaching service - 9907071685
    ///
    /// IT service - 9907101676
    ///
    /// Digital services and electronic medium - 9907121690
    ///
    /// **Nepal**
    ///
    /// * The sector valid values are `Business` and `Individual`.
    ///
    /// **Saudi Arabia**
    ///
    /// * For `address`, you must specify `addressLine3`.
    ///
    /// **South Korea**
    ///
    /// * You must specify the `certifiedEmailId` and `legalName` in the
    /// `TaxRegistrationEntry` object. Use Korean characters for
    /// `legalName`.
    ///
    /// * You must specify the `businessRepresentativeName`,
    /// `itemOfBusiness`, and `lineOfBusiness` in the
    /// `southKoreaAdditionalInfo` field of the `additionalTaxInformation`
    /// object. Use Korean characters for these fields.
    ///
    /// * You must specify the tax registration certificate document in the
    /// `taxRegistrationDocuments` field of the `VerificationDetails`
    /// object.
    ///
    /// * For the `address` object, use Korean characters for `addressLine1`,
    ///   `addressLine2`
    /// `city`, `postalCode`, and `stateOrRegion`.
    ///
    /// **Spain**
    ///
    /// * You must specify the `registrationType` in the
    /// `spainAdditionalInfo` field of the `additionalTaxInformation`
    /// object.
    ///
    /// * If the `registrationType` is `Local`, you must specify the tax
    /// registration certificate document in the `taxRegistrationDocuments` field of
    /// the `VerificationDetails` object.
    ///
    /// **Turkey**
    ///
    /// * You must specify the `sector` in the `taxRegistrationEntry` object.
    ///
    /// * If your `sector` is `Business`, `Individual`, or
    /// `Government`:
    ///
    /// * Specify the `taxOffice`. If your
    /// `sector` is `Individual`, don't enter this value.
    ///
    /// * (Optional) Specify the `kepEmailId`. If your
    /// `sector` is `Individual`, don't enter this value.
    ///
    /// * **Note:** In the **Tax Settings** page of the Billing console,
    ///   `Government` appears as **Public institutions**
    ///
    /// * If your `sector` is `Business` and you're subject to KDV tax,
    /// you must specify your industry in the `industries` field.
    ///
    /// * For `address`, you must specify `districtOrCounty`.
    ///
    /// **Ukraine**
    ///
    /// * The sector valid values are `Business` and `Individual`.
    pub fn putTaxRegistration(self: *Self, allocator: std.mem.Allocator, input: put_tax_registration.PutTaxRegistrationInput, options: CallOptions) !put_tax_registration.PutTaxRegistrationOutput {
        return put_tax_registration.execute(self, allocator, input, options);
    }

    pub fn listSupplementalTaxRegistrationsPaginator(self: *Self, params: list_supplemental_tax_registrations.ListSupplementalTaxRegistrationsInput) paginator.ListSupplementalTaxRegistrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTaxExemptionsPaginator(self: *Self, params: list_tax_exemptions.ListTaxExemptionsInput) paginator.ListTaxExemptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTaxRegistrationsPaginator(self: *Self, params: list_tax_registrations.ListTaxRegistrationsInput) paginator.ListTaxRegistrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
