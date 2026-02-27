const CreateAccountFailureReason = @import("create_account_failure_reason.zig").CreateAccountFailureReason;
const CreateAccountState = @import("create_account_state.zig").CreateAccountState;

/// Contains the status about a CreateAccount or CreateGovCloudAccount request
/// to create an Amazon Web Services account or an Amazon Web Services
/// GovCloud (US) account in an organization.
pub const CreateAccountStatus = struct {
    /// If the account was created successfully, the unique identifier (ID) of the
    /// new
    /// account.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for an account ID
    /// string requires exactly 12
    /// digits.
    account_id: ?[]const u8,

    /// The account name given to the account when it was created.
    account_name: ?[]const u8,

    /// The date and time that the account was created and the request completed.
    completed_timestamp: ?i64,

    /// If the request failed, a description of the reason for the failure.
    ///
    /// * ACCOUNT_LIMIT_EXCEEDED: The account couldn't be created because you
    ///   reached
    /// the limit on the number of accounts in your organization.
    ///
    /// * CONCURRENT_ACCOUNT_MODIFICATION: You already submitted a request with the
    ///   same
    /// information.
    ///
    /// * EMAIL_ALREADY_EXISTS: The account could not be created because another
    ///   Amazon Web Services
    /// account with that email address already exists.
    ///
    /// * FAILED_BUSINESS_VALIDATION: The Amazon Web Services account that owns your
    ///   organization
    /// failed to receive business license validation.
    ///
    /// * GOVCLOUD_ACCOUNT_ALREADY_EXISTS: The account in the Amazon Web Services
    ///   GovCloud (US) Region
    /// could not be created because this Region already includes an account with
    /// that
    /// email address.
    ///
    /// * IDENTITY_INVALID_BUSINESS_VALIDATION: The Amazon Web Services account that
    ///   owns your
    /// organization can't complete business license validation because it doesn't
    /// have
    /// valid identity data.
    ///
    /// * INVALID_ADDRESS: The account could not be created because the address you
    /// provided is not valid.
    ///
    /// * INVALID_EMAIL: The account could not be created because the email address
    ///   you
    /// provided is not valid.
    ///
    /// * INVALID_PAYMENT_INSTRUMENT: The Amazon Web Services account that owns your
    ///   organization does
    /// not have a supported payment method associated with the account. Amazon Web
    /// Services does not
    /// support cards issued by financial institutions in Russia or Belarus. For
    /// more
    /// information, see [Managing your
    /// Amazon Web Services
    /// payments](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/manage-general.html).
    ///
    /// * INTERNAL_FAILURE: The account could not be created because of an internal
    /// failure. Try again later. If the problem persists, contact Amazon Web
    /// Services Customer
    /// Support.
    ///
    /// * MISSING_BUSINESS_VALIDATION: The Amazon Web Services account that owns
    ///   your organization has
    /// not received Business Validation.
    ///
    /// * MISSING_PAYMENT_INSTRUMENT: You must configure the management account with
    ///   a
    /// valid payment method, such as a credit card.
    ///
    /// * PENDING_BUSINESS_VALIDATION: The Amazon Web Services account that owns
    ///   your organization is
    /// still in the process of completing business license validation.
    ///
    /// * UNKNOWN_BUSINESS_VALIDATION: The Amazon Web Services account that owns
    ///   your organization has
    /// an unknown issue with business license validation.
    failure_reason: ?CreateAccountFailureReason,

    /// If the account was created successfully, the ID for the new account in the
    /// Amazon Web Services
    /// GovCloud (US) Region.
    gov_cloud_account_id: ?[]const u8,

    /// The unique identifier (ID) that references this request. You get this value
    /// from the
    /// response of the initial CreateAccount request to create the
    /// account.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a create account
    /// request ID string
    /// requires "car-" followed by from 8 to 32 lowercase letters or digits.
    id: ?[]const u8,

    /// The date and time that the request was made for the account creation.
    requested_timestamp: ?i64,

    /// The status of the asynchronous request to create an Amazon Web Services
    /// account.
    state: ?CreateAccountState,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_name = "AccountName",
        .completed_timestamp = "CompletedTimestamp",
        .failure_reason = "FailureReason",
        .gov_cloud_account_id = "GovCloudAccountId",
        .id = "Id",
        .requested_timestamp = "RequestedTimestamp",
        .state = "State",
    };
};
