def generate_jwt_for_user(user)
  jwt_token = ::JsonWebToken.encode({ digest: user.digest })
  allow(JsonWebToken).to receive(:decode).with(jwt_token)  { {digest: user.digest} }
  jwt_token
end