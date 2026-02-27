/// Types of PII entities that can be detected, we will support every types that
/// Guardrails can support
pub const PIIEntityType = enum {
    /// All supported PII entity types
    all,
    /// A physical address, such as '100 Main Street, Anytown, USA' or 'Suite #12,
    /// Building 123'
    address,
    /// An individual's age, including the quantity and unit of time
    age,
    /// An individual's name. Does not include titles such as Dr., Mr., Mrs., or
    /// Miss
    name,
    /// An email address, such as marymajor@email.com
    email,
    /// A phone number. Also includes fax and pager numbers
    phone,
    /// A user name that identifies an account, such as a login name, screen name,
    /// nick name, or handle
    username,
    /// An alphanumeric string that is used as a password
    password,
    /// The number assigned to a driver's license
    driver_id,
    /// A license plate for a vehicle issued by the state or country where the
    /// vehicle is registered
    license_plate,
    /// A Vehicle Identification Number (VIN) that uniquely identifies a vehicle
    vehicle_identification_number,
    /// A three-digit card verification code (CVV) for VISA, MasterCard, and
    /// Discover cards, or four-digit for American Express
    credit_debit_card_cvv,
    /// The expiration date for a credit or debit card
    credit_debit_card_expiry,
    /// The number for a credit or debit card
    credit_debit_card_number,
    /// A four-digit personal identification number (PIN)
    pin,
    /// An International Bank Account Number with specific formats for each country
    international_bank_account_number,
    /// A SWIFT code - standard format of Bank Identifier Code (BIC)
    swift_code,
    /// An IPv4 address, such as 198.51.100.0
    ip_address,
    /// A media access control (MAC) address - unique identifier for network
    /// interface controller
    mac_address,
    /// A web address, such as www.example.com
    url,
    /// A unique identifier associated with AWS secret access key
    aws_access_key,
    /// A unique identifier associated with AWS access key for signing programmatic
    /// requests
    aws_secret_key,
    /// A US bank account number, typically 10 to 12 digits long
    us_bank_account_number,
    /// A US bank account routing number, typically nine digits long
    us_bank_routing_number,
    /// A US Individual Taxpayer Identification Number (ITIN)
    us_individual_tax_identification_number,
    /// A US passport number, ranging from six to nine alphanumeric characters
    us_passport_number,
    /// A US Social Security Number (SSN) - nine-digit number for US citizens and
    /// residents
    us_social_security_number,
    /// A Canadian Health Service Number - 10-digit unique identifier for healthcare
    /// benefits
    ca_health_number,
    /// A Canadian Social Insurance Number (SIN) - nine-digit unique identifier
    ca_social_insurance_number,
    /// A UK National Health Service Number - 10-17 digit number
    uk_national_health_service_number,
    /// A UK National Insurance Number (NINO) for accessing National Insurance
    /// benefits
    uk_national_insurance_number,
    /// A UK Unique Taxpayer Reference (UTR) - 10-digit number identifying taxpayer
    /// or business
    uk_unique_taxpayer_reference_number,

    pub const json_field_names = .{
        .all = "ALL",
        .address = "ADDRESS",
        .age = "AGE",
        .name = "NAME",
        .email = "EMAIL",
        .phone = "PHONE",
        .username = "USERNAME",
        .password = "PASSWORD",
        .driver_id = "DRIVER_ID",
        .license_plate = "LICENSE_PLATE",
        .vehicle_identification_number = "VEHICLE_IDENTIFICATION_NUMBER",
        .credit_debit_card_cvv = "CREDIT_DEBIT_CARD_CVV",
        .credit_debit_card_expiry = "CREDIT_DEBIT_CARD_EXPIRY",
        .credit_debit_card_number = "CREDIT_DEBIT_CARD_NUMBER",
        .pin = "PIN",
        .international_bank_account_number = "INTERNATIONAL_BANK_ACCOUNT_NUMBER",
        .swift_code = "SWIFT_CODE",
        .ip_address = "IP_ADDRESS",
        .mac_address = "MAC_ADDRESS",
        .url = "URL",
        .aws_access_key = "AWS_ACCESS_KEY",
        .aws_secret_key = "AWS_SECRET_KEY",
        .us_bank_account_number = "US_BANK_ACCOUNT_NUMBER",
        .us_bank_routing_number = "US_BANK_ROUTING_NUMBER",
        .us_individual_tax_identification_number = "US_INDIVIDUAL_TAX_IDENTIFICATION_NUMBER",
        .us_passport_number = "US_PASSPORT_NUMBER",
        .us_social_security_number = "US_SOCIAL_SECURITY_NUMBER",
        .ca_health_number = "CA_HEALTH_NUMBER",
        .ca_social_insurance_number = "CA_SOCIAL_INSURANCE_NUMBER",
        .uk_national_health_service_number = "UK_NATIONAL_HEALTH_SERVICE_NUMBER",
        .uk_national_insurance_number = "UK_NATIONAL_INSURANCE_NUMBER",
        .uk_unique_taxpayer_reference_number = "UK_UNIQUE_TAXPAYER_REFERENCE_NUMBER",
    };
};
