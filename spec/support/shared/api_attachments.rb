shared_examples_for 'API Attachments' do
  context 'files' do
    let(:file) { obj.files.first.blob }
    let(:files_response) { resource_response['files'] }
    let(:file_response) { files_response.first }

    it 'return object of files' do
      expect(file_response['id']).to eq obj.files.first.id
    end

    it 'returns all public fields' do
      %w[id filename].each do |attr|
        expect(file_response[attr]).to eq file.send(attr).as_json
      end
    end
  end

  context 'links' do
    let(:link)           { links.first }
    let(:links_response) { resource_response['links'] }
    let(:link_response)  { links_response.first }

    it 'rerurn list of links' do
      expect(links_response.size).to eq links.size
    end

    it 'returns all public fields' do
      %w[id name url created_at updated_at].each do |attr|
        expect(link_response[attr]).to eq link.send(attr).as_json
      end
    end
  end

  context 'comments' do
    let(:comment) { comments.first }
    let(:comments_response) { resource_response['comments'] }
    let(:comment_response) { comments_response.first }

    it 'rerurn list of comments' do
      expect(comments_response.size).to eq comments.size
    end

    it 'returns all public fields' do
      %w[id body created_at updated_at].each do |attr|
        expect(comment_response[attr]).to eq comment.send(attr).as_json
      end
    end
  end
end