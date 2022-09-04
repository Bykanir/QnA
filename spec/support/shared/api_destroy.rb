shared_examples_for 'API Destroy' do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  it 'return 200 status' do
    do_request(method, api_path, params: { id: resource, access_token: access_token.token }, headers: headers)
    expect(response).to be_successful
  end

  it 'removed from db' do
    expect do
      do_request(method, api_path, params: { id: resource, access_token: access_token.token }, headers: headers)
    end.to change(resource, :count).by(0)
  end
end