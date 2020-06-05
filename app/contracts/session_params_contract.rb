class SessionParamsContract < Dry::Validation::Contract
  params do
    required(:session).hash do
      required(:email).value(:string)
      required(:password).value(:string)
    end
  end
end
